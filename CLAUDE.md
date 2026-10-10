# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal portfolio/blog site for Taylor Jones, live at https://hiimtaylorjones.com. Built with Ruby 3.4.5 and Rails 8.0.5, deployed on Heroku with PostgreSQL and AWS S3 for file storage.

The internal Rails module name is `Everythingisruby::Application`.

## Coding Style

### Comments

Should be short and somewhat verbose. Emphasis on human readable content that briefly describes important or complex code sections. More info can be added on later iterations - if approved.

## Common Commands

```bash
# Install dependencies
bundle install

# Start development server (Puma + Dartsass CSS watcher via Heroku CLI)
heroku local -f Procfile.dev

# Run all tests
bundle exec rspec spec

# Run a single test file
bundle exec rspec spec/models/post_spec.rb

# Database setup
bundle exec rake db:create db:migrate
bundle exec rake db:seed

# Rails console
bundle exec rails console
```

## Architecture

**Models:**
- `Post` — Blog posts with title, tagline, body, banner image attachment (Active Storage), friendly URL slugs, and a `published` boolean flag. `belongs_to :collection, optional: true`.
- `Collection` — A named grouping of posts, e.g. a multi-part series. Title, description, friendly slug, and an `active` flag (not `published` — see below). `has_many :posts, dependent: :nullify`.
- `Admin` — Devise-authenticated admin users. Only one admin exists in practice.

There is no tagging and no commenting. Tags were dropped in `db/migrate/20250130184410_remove_tags_and_taggings.rb`; the `Comment`/`Response` models and their tables were removed in `db/migrate/20261010132014_drop_comments_and_responses.rb`.

**Key Libraries:**
- FriendlyId for slug-based URLs on Posts and Collections (`Post.friendly.find(params[:id])`). Both use `:slugged` without overriding `should_generate_new_friendly_id?`, so renaming a record keeps its original slug.
- Commonmarker for Markdown rendering — two places: `ApplicationHelper#markdown` for post bodies in ERB, and `Handlers::MarkdownHandler` registered as a template handler for `.html.md` view files
- Devise for admin authentication (`authenticate_admin!`, `admin_signed_in?`)
- Will Paginate for pagination
- Propshaft asset pipeline with Dartsass for SCSS compilation
- Stimulus for JavaScript (only `sidebar_controller.js` — hamburger menu toggle)
- Solid Queue/Cache/Cable (Rails 8 defaults)

**Routes:** Root points to `basic_page#refresh`. Working routes: `resources :posts`, `resources :collections`, `/admin`, `/resume`. Undefined paths redirect to root with a flash notice via the `get '*path'` catch-all — **any new route must be declared above it**.

Known dead routes: `resources :pages, param: :title` is declared but there is no `Page` model and no `PagesController`, so every `/pages/*` request raises. `BasicPageController#index` and `app/views/basic_page/index.html.erb` have no route pointing at them.

**Content pages:** The home page (`app/views/basic_page/refresh.html.md`) and resume (`app/views/basic_page/resume.html.md`) are plain Markdown files rendered via the custom `MarkdownHandler`. Editing them directly updates the page content — no controller logic involved.

**Post partials:** Two, and the distinction matters. `app/views/posts/_full_post.html.erb` renders a post's complete Markdown body and is for single-post pages and the post index. `app/views/posts/_post_summary.html.erb` renders only title, tagline and date, and is what listing pages use — rendering `_full_post` in a loop dumps every member post's full body onto one screen.

**Views:** The v2 layout (`app/views/layouts/v2/_layout.html.erb`) wraps all pages. It includes a header with a hamburger menu that opens a Stimulus-controlled sidebar. The `@content_class` instance variable can be set in controllers to add a CSS class to the content column (used by `resume` action).

**Assets:** `application.scss` is the only SCSS entry point and the only file the layout links. It `@use`s `v2` and `navigation` (which are not underscore-prefixed but are consumed as partials, not built separately) plus `_buttons`, `_forms`, `_resume`, `_tables`, `_utilities`, `_variables`. There is no dartsass initializer, so `dartsass:build` compiles `application.scss` alone. JavaScript via ImportMap.

Collections views reuse the existing `table`, `primary-button`, `warning-button`, `danger-button` and `content-divider` classes; their own wrapper classes (`collections-index`, `collection-summary`, `post-summary`, `admin-collections-index`) are currently unstyled and inherit the content column.

**Admin flow:** Posting requires admin login. CRUD on both posts and collections is protected by `before_action :authenticate_admin!`. The admin dashboard is at `/admin` (rendered by `basic_page#admin`) and lists posts and collections in separate tables — it shows *all* of both, regardless of `published`/`active`.

## Collections: active vs. published

A post belongs to **at most one** collection — a nullable `posts.collection_id` FK, not a join table — and there is no explicit ordering, so posts within a collection sort by date.

The two models carry **deliberately different** flags, because they answer different questions:

- **`Post#published`** is a *visibility* question — is this writing public? It is the sole authority on whether a post is readable, and a collection never overrides it.
- **`Collection#active`** is a *semantic* question — does this grouping apply at all? An inactive collection's grouping does not apply, so its member posts read as **unclassified** anywhere a visitor can see: no "Part of" line, no link, no public page.

| `post.published` | `collection.active` | `/posts/:slug` | "Part of" line | `/collections/:slug` | On `/collections` |
|---|---|---|---|---|---|
| yes | yes | visible | shown | visible | yes |
| yes | no | visible | **hidden** | admin only | no |
| no | yes | redirects | — | visible, post omitted | yes |
| no | no | redirects | — | admin only | no |

The naming is the point, so resist "consistency" here. Both flags were once called `published`, which meant every surface needed its own judgment about which one governed — and one got it wrong, rendering an unpublished collection's title and URL on the public post page with a link that bounced the visitor. `active` gives one rule to apply everywhere instead. Renaming `Post#published` to match would recreate the ambiguity.

Deactivating is a **reversible un-grouping**: membership rows survive, so flipping `active` back reassembles the series. Destroying is the irreversible version, and nullifies rather than cascading.

Four choices here are load-bearing; changing them breaks things quietly:

- **`has_many :posts, dependent: :nullify`** on `Collection`. The reflex is `:destroy`, but deleting a *grouping* must never delete the writing inside it. Member posts fall back to standalone.
- **`belongs_to :collection, optional: true`** on `Post`. Required, not stylistic — `belongs_to` is mandatory by default in Rails 5+, so dropping `optional` makes every collection-less post fail validation.
- **Flat routes.** `resources :collections` sits alongside `resources :posts`, never nested. Nesting would give every post a second URL (`/collections/x/posts/y` as well as `/posts/y`), splitting SEO between duplicates. The collection page links out via `post_path`.
- **The "Part of" guard** in `_full_post.html.erb` checks `post.collection.active? || admin_signed_in?`, not just `collection.present?`. Loosening it is the exact leak described above. Admins see inactive collections marked `(inactive)` so the post page stays navigable.

Scopes: `Collection.active`, and `Collection.listable` for the index — active collections with at least one published post, which keeps dead-end pages off the listing while leaving them reachable by direct URL. `Post.published` for posts.

**`posts.published` has no DB default**, so legacy rows are `NULL` rather than `false`. Always filter with `Post.published` and test with `published?` — `published == false` silently misses NULL rows, which is how an unpublished post once rendered publicly. (`collections.active` does default to `false, null: false`, so a new collection starts inactive.)

## CI

`.github/workflows/ci.yml` runs on every push and pull request: Postgres 16 service container, Ruby 3.4.5 via `ruby/setup-ruby` with gem caching, then `rails db:schema:load`, `rails dartsass:build`, `rspec spec`. The CSS build step is required — some specs render views that call `stylesheet_link_tag`.

## Testing

RSpec with FactoryBot factories in `spec/factories/`. Devise test helpers are configured for `:controller` and `:view` types in `rails_helper.rb`. Test coverage: models, controllers, requests, helpers, mailers.

**Controller specs do not render views by default.** Any spec that asserts on markup, or that exists to catch an ERB error, needs `render_views` in the describe block — `collections_controller_spec.rb` and `basic_page_controller_spec.rb` use it, and so do the post specs covering the collection select and the banner image.

Factory traits worth knowing:
- `:post` — `:unpublished` (`published: false`), `:never_published` (`published: nil`, the legacy NULL case), `:with_banner_image` (attaches `spec/fixtures/files/banner.png`)
- `:collection` — `:inactive`, `:with_posts` (accepts a `post_count`, default 3)

## Linting

A `.reek` config exists at the project root (it disables `IrresponsibleModule` for controllers/helpers, `UnusedPrivateMethod` for controllers, and `InstanceVariableAssumption` for controllers/helpers/mailers), but **reek is not in the Gemfile**, so `bundle exec reek app` does not run. Install it before relying on the config.

## Environment Variables (Production)

`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` (S3 storage), `DB_USERNAME`, `DB_PASSWORD`, `SECRET_TEST_PASSWORD`.

## Pull Request Creation

When generating a pull request, include a section with `###`-titled text called `AI Notes`. These notes should include three to five short bullet points of what changes are included in the PR. The goal here is to reduce vebose output while giving good starting notes for the PR. 