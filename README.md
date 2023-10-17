# README

This app is a helper for using ChatGPT to create entertaining, long-lived role-play characters. 

I do not intend to run this app in a "production" (live, on-web) environment, due to OpenAI costs. But, I hope folks
take the opportunity to run this locally.

The front-end is built in React: https://github.com/colemanja91/chatgpt-roleplay-ui


### What it does

* Uses chat completion "system" messages to set the rules that the AI must follow
* Sends input prompts to OpenAI, along with recent message history and system message
  * Recent history is cutoff after some point based on the OpenAI max token limit
* Stores message history and system message in database for future reference
  * Allows for long-lived characters
* Enables variable temperature
  * Temperature controls how deterministic or random the output should be
  * Default of 1 is used (same as ChatGPT)
  * Enabling the appropriate option on message send will randomly select a valid temperature value to use
  * Can help make things more interesting over time by ensuring ChatGPT doesn't always send easily-guessable responses
* Serves functionality as a GraphQL API

### Example 1 - System Prompt + Most Recent Messages

* Your character has the following state:
  * System message of 500 tokens
  * Message history of 100 messages (both `user` and `assistant`)
    * Each message length is 50 tokens (simplification for the sake of example, in reality this will be variable)
  * New input message of 150 tokens
* In order to meet OpenAI's API token size limits, the following will be sent:
  * The system message
  * The new input message
  * The most recent 32 messages from history
  * Total request token size: 3,850

## Setup

### Ruby Version

`.ruby-version` defines the current version; [rbenv](https://github.com/rbenv/rbenv) is recommended for version management.

### Postgres

This app was developed against PostgreSQL 14.

### Redis

Doesn't really matter what, just get it running.

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

## Running App

```sh
bundle exec rails s
```

GraphQL queries can be routed to `http://127.0.0.1:3000/graphql`. 

Graphiql is mounted at [http://127.0.0.1:3000/graphiql](http://127.0.0.1:3000/graphiql) and can be used for schema introspection and testing.

## TODO

Initial development is happening during Twitch streams, and we'll use this as our backend work tracker for now.

**Now**

**Next**

* Generate a summary message from a range of message history
  * Ask ChatGPT to summarize history in 1 - 2 sentences and provide an importance score of 0 - 10
  * Store
    * Raw response (for debugging)
    * Response without importance score
    * Importance score
* Add Sidekiq + Redis for background processing
* Enqueue a job to generate summary messages after every message send
  * Should be idempotent if no summary is needed
* Include summaries in system message
  * Only summaries generated from messages before current message range
  * Only the top 3 summaries ranked by ChatGPT-determined importance and recency
  * Toggleable via API

**Later**

* Explore using GraphQL Subscriptions for messages
  * If it works, move OpenAI calls to a background job
* Dockerize?
