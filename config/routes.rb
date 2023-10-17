require "sidekiq/web"
require "sidekiq-scheduler/web"

Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  mount Sidekiq::Web => "/sidekiq"

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
end
