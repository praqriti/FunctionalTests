profile = ENV['RAILS_ENV'] || 'default'

ENV_CONFIG = YAML.load(File.read("features/env_profile.yml"))[profile]

CANVAS_URL = "#{ENV_CONFIG['canvas_url']}"

CANVAS_API = "#{ENV_CONFIG['canvas_url']}/api/v1"

SEN_URL = "#{ENV_CONFIG['sen_url']}/ussd/index"

CANVAS_ACCESS_TOKEN = "#{ENV_CONFIG['access_token']}"

ACCOUNT_ID = 1

DEFAULT_CANVAS_USER = CanvasUserInterface.create_user("user_one@test.com","password_one")

Capybara.app_host = CANVAS_URL
Capybara.default_selector = :css
Capybara.default_driver = :selenium_firefox 
# Capybara.javascript_driver = :selenium_chrome
Capybara.javascript_driver = :webkit



