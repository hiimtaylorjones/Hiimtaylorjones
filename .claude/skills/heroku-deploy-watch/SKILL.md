---
name: heroku-deploy-watch
description: Check whether a Heroku deploy of this site is healthy (build, release phase, dynos, /up and key pages, error logs) and prepare a revert if it is not. Use after merging a PR to main, when asked "did the deploy work?", or to look into a failed Deploy check workflow run.
---

# Watching a Heroku deploy

Heroku auto-deploys every push to `main` of the `hiimtaylorjones` app. Heroku
app webhooks reach this app's `POST /webhooks/heroku`, which starts the
`Deploy check` GitHub workflow for every finished build, rollback and config
change. That workflow runs `bin/deploy-check` and opens a draft revert PR when
a code deploy is unhealthy. AGENTS.md ("Deploys") has the full chain.

## Check

1. **Look for the workflow run first**; it has usually already happened:
   `gh run list --workflow "Deploy check" -L 5`, then `gh run view <id> --log`.
   Its job summary is the report.
2. No run, or it should be re-checked? Run it locally in the background:
   - a code deploy: `bin/deploy-check --sha <merge commit> --report tmp/deploy-report.md`
     (find the commit with `git fetch && git log -1 origin/main`)
   - a rollback or config change: `bin/deploy-check --release <version> --report tmp/deploy-report.md`
3. Read the exit code: `0` healthy, `1` unhealthy, `2` inconclusive (no build
   found, API error, or the checker itself failed). Inconclusive is not a
   verdict on the deploy, so never prepare a revert for it.

## When no workflow run appeared

The relay is broken somewhere. Check in order:

- `heroku webhooks -a hiimtaylorjones` lists the subscription, and
  `heroku webhooks:deliveries -a hiimtaylorjones` shows recent attempts. A 401
  means the signing secret does not match `HEROKU_WEBHOOK_SECRET`; 503 means
  that config var is missing; 502 means GitHub refused the dispatch (look for
  "Heroku webhook not forwarded to GitHub" in `heroku logs`, usually an
  expired or under-scoped `GITHUB_DISPATCH_TOKEN`).
- Remember `repository_dispatch` only runs the workflow as it exists on `main`.

## When it is unhealthy

The report names the failed step. Look deeper before reporting:

- **build**: the build output is in the report. Nothing went live.
- **release**: the release phase (`rake db:migrate`) failed. It runs on every
  deploy, migrations or not. The report includes the output.
- **dynos**: `heroku logs -a hiimtaylorjones -n 300 --dyno web` for the boot error.
- **http / logs**: `heroku logs -a hiimtaylorjones -n 500` around the failing path.

Then give the user both ways out, and let them choose:

- **Now:** `heroku rollback v<previous> -a hiimtaylorjones` (in the report).
- **On main:** a draft revert PR. If the workflow did not open one, run
  `bin/deploy-revert-pr --bad <sha> --previous <previous_sha> --version <v> --report tmp/deploy-report.md`
  (try `--dry-run` first).

A bad rollback or config change has no commit to revert, so no revert PR is
opened. The way out there is the reverse change (roll forward, or restore the
config var), which is the user's call.

## Rules

- Never run `heroku rollback`, merge a revert PR, or `heroku run rails db:rollback`
  yourself. Those change the live site or its database; suggest them and wait.
- Never run `heroku config` or `heroku releases:info`. Both print every config
  var, AWS keys included. `bin/deploy-check` avoids them for that reason.
- Neither a rollback nor a revert undoes a migration. If the bad release added
  one, say so, and name the migration.
