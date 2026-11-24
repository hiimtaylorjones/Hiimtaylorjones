---
name: heroku-deploy-watch
description: Check whether a Heroku deploy of this site is healthy (build, release phase, dynos, /up and key pages, error logs) and prepare a revert if it is not. Use after merging a PR to main, when asked "did the deploy work?", or to look into a failed Deploy check workflow run.
---

# Watching a Heroku deploy

Heroku auto-deploys every push to `main` of the `hiimtaylorjones` app. The
`Deploy check` GitHub workflow (`.github/workflows/deploy-check.yml`) already
runs `bin/deploy-check` after each push and opens a draft revert PR when a
release is unhealthy. This skill is for doing the same by hand in a session.

## Check

1. Find the commit: the merge commit on `origin/main` (`git fetch && git log -1 origin/main`).
2. Run `bin/deploy-check --sha <sha> --report tmp/deploy-report.md` in the
   background. It waits up to 20 minutes for Heroku to build and release.
3. Read the exit code: `0` healthy, `1` unhealthy, `2` inconclusive (no build
   for that commit, API error, or the checker itself crashed). Inconclusive is
   not a verdict on the deploy, so never prepare a revert for it.

If the workflow already ran, read its job summary instead of re-running:
`gh run list --workflow "Deploy check" -L 5`, then `gh run view <id> --log`.

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

## Rules

- Never run `heroku rollback`, merge a revert PR, or `heroku run rails db:rollback`
  yourself. Those change the live site or its database; suggest them and wait.
- Never run `heroku config` or `heroku releases:info`. Both print every config
  var, AWS keys included. `bin/deploy-check` avoids them for that reason.
- Neither a rollback nor a revert undoes a migration. If the bad release added
  one, say so, and name the migration.
