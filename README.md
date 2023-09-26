# README

This app is a helper for using ChatGPT to create entertaining, long-lived role-play characters. 

I do not intend to run this app in a "production" (live, on-web) environment, due to OpenAI costs. But, I hope folks
take the opportunity to run this locally.

## Setup

### Ruby Version

`.ruby-version` defines the current version; [rbenv](https://github.com/rbenv/rbenv) is recommended for version management.

### Postgres

This app was developed against PostgreSQL 14.

### Local setup

Install dependencies:

```sh
bundle
```

Setup databases:

```sh
bundle exec rails db:create
bundle exec rails db:migrate
```

### Running tests

```sh
bundle exec rspec
```

### Credentials

In the OpenAI developer console, create a new access token and set it in your environment as `OPENAI_ACCESS_TOKEN`.
If you want to use a different environment variable, you can update the setting value in `config/settings.default.yml`.

## TODO

Initial development is happening during Twitch streams, and we'll use this as our work tracker for now.

* Dockerize?
* Specs
* Better cutoff limits around tokens
* Implement summaries
* Rake tasks? 
* Explore audio capture (if frontend, then setup API)
* integrate with speech-to-text
