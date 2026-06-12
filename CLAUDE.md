# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal portfolio/blog site for Taylor Jones, live at https://hiimtaylorjones.com. Built with Ruby 3.4.5 and Rails 8.0.2, deployed on Heroku with PostgreSQL and AWS S3 for file storage.

The internal Rails module name is `Everythingisruby::Application`.

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

# Lint for code smells
bundle exec reek app

# Database setup
bundle exec rake db:create db:migrate
bundle exec rake db:seed

# Rails console
bundle exec rails console
```

## Architecture

**Models:**
- `Post` — Blog posts with title, tagline, body, banner image attachment (Active Storage), friendly URL slugs, and a `published` boolean flag. Tags via acts-as-taggable-on (max 12 char tags). Has many comments.
- `Comment` — Comments belonging to posts.
- `Admin` — Devise-authenticated admin users. Only one admin exists in practice.
- `Response` — Feedback/contact responses.

**Key Libraries:**
- FriendlyId for slug-based URLs on Posts (`Post.friendly.find(params[:id])`)
- Commonmarker for Markdown rendering — two places: `ApplicationHelper#markdown` for post bodies in ERB, and `Handlers::MarkdownHandler` registered as a template handler for `.html.md` view files
- Devise for admin authentication (`authenticate_admin!`, `admin_signed_in?`)
- Will Paginate for pagination
- Propshaft asset pipeline with Dartsass for SCSS compilation
- Stimulus for JavaScript (only `sidebar_controller.js` — hamburger menu toggle)
- Solid Queue/Cache/Cable (Rails 8 defaults)

**Routes:** Root points to `basic_page#refresh`. Active routes: `resources :posts`, `resources :pages, param: :title`, `/admin`, `/resume`. Undefined paths redirect to root with a flash notice.

**Content pages:** The home page (`app/views/basic_page/refresh.html.md`) and resume (`app/views/basic_page/resume.html.md`) are plain Markdown files rendered via the custom `MarkdownHandler`. Editing them directly updates the page content — no controller logic involved.

**Views:** The v2 layout (`app/views/layouts/v2/_layout.html.erb`) wraps all pages. It includes a header with a hamburger menu that opens a Stimulus-controlled sidebar. The `@content_class` instance variable can be set in controllers to add a CSS class to the content column (used by `resume` action).

**Assets:** SCSS entry points: `application.scss` (imports partials: `_buttons`, `_forms`, `_resume`, `_tables`, `_utilities`, `_variables`), `navigation.scss`, `v2.scss`. JavaScript via ImportMap.

**Admin flow:** Posting requires admin login. CRUD on posts is protected by `before_action :authenticate_admin!`. The admin dashboard is at `/admin` (rendered by `basic_page#admin`).

## Testing

RSpec with FactoryBot factories in `spec/factories/`. Devise test helpers are configured for `:controller` and `:view` types in `rails_helper.rb`. Test coverage: models, controllers, mailers.

## Linting

Reek is configured via `.reek` at the project root. It disables `IrresponsibleModule` for controllers/helpers, `UnusedPrivateMethod` for controllers, and `InstanceVariableAssumption` for controllers/helpers/mailers.

## Environment Variables (Production)

`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` (S3 storage), `DB_USERNAME`, `DB_PASSWORD`, `SECRET_TEST_PASSWORD`.
