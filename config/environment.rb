# Load the Rails application.
require_relative "application"

Setting.load(path: "#{Rails.root}/config/settings", files: ["default.yml"])

# Initialize the Rails application.
Rails.application.initialize!
