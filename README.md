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
* Rake tasks? 
* Explore audio capture (if frontend, then setup API)
* integrate with speech-to-text
* Implement summaries

Summaries / tokens
* persist token estimate to the DB on create/update
* dynamically construct message context size

TOTAL LIMIT - 100 (buffer for estimates) - NewMessageTokens - SystemMessageTokens = VariableLimit

4096 - 100 - 200 - 1000 = 2,796

VariableLimit * 0.66 = MaxSummarySize
VariableLimit - ActualSummarySize = RecentMessageSize

1/3 recent messages
2/3 summaries

How often do we generate summaries?
* Every 1,200 tokens? 

## Audio

https://apple.stackexchange.com/questions/326388/terminal-command-to-record-audio-through-macbook-microphone

https://cloud.google.com/speech-to-text/docs/samples/speech-transcribe-auto-punctuation?hl=en#speech_transcribe_auto_punctuation-ruby
