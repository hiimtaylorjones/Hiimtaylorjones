# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal portfolio/blog site for Taylor Jones, live at https://hiimtaylorjones.com. Built with Ruby 3.4.5 and Rails 8.0.2, deployed on Heroku with PostgreSQL and AWS S3 for file storage.

The internal Rails module name is `Everythingisruby::Application`.

## Common Commands

```bash
# Install dependencies
bundle install

# Start development server (runs Puma + Dartsass CSS watcher via Heroku CLI)
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
- `Post` — Blog posts with title, body, tags (acts-as-taggable-on, max 12 char tags), comments, banner image attachment (Active Storage), friendly URL slugs, and a published flag
- `Page` — Static content pages with title, content, placement ("navbar" or "none"), friendly slugs, and published scope
- `Comment` — Comments belonging to posts
- `Admin` — Devise-authenticated admin users
- `Response` — Feedback/contact responses

**Key Libraries:**
- FriendlyId for slug-based URLs on Posts and Pages
- Commonmarker for Markdown rendering (custom `MarkdownHandler` in `lib/handlers/`)
- Devise for admin authentication
- Will Paginate for pagination
- Propshaft asset pipeline with Dartsass for SCSS compilation
- Solid Queue/Cache/Cable (Rails 8 defaults)

**API:** Versioned REST API under `app/controllers/api/v1/` with controllers for posts, pages, and comments.

**Routes:** Root points to `basic_page#refresh`. Most resource routes are currently commented out. Undefined paths redirect to root with a flash notice. Health check at `/up`.

**Views:** ERB templates using layouts in `app/views/layouts/`. Main sections: `basic_page` (home), `posts`, `pages`, `devise` (auth).

**Assets:** SCSS files (`application.scss`, `navigation.scss`, `v2.scss`) compiled by Dartsass. JavaScript via ImportMap.

## Testing

RSpec with FactoryBot factories in `spec/factories/`. Devise test helpers are configured in `rails_helper.rb`. Tests cover models, controllers, requests, and mailers.

## Linting

Reek is configured via `.reek` at the project root. It disables `IrresponsibleModule` for controllers/helpers, `UnusedPrivateMethod` for controllers, and `InstanceVariableAssumption` for controllers/helpers/mailers.

## Environment Variables (Production)

`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` (S3 storage), `DB_USERNAME`, `DB_PASSWORD`, `SECRET_TEST_PASSWORD`.
