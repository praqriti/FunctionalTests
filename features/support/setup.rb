$: << File.join(File.dirname(__FILE__), '../..')

profile = ENV['RAILS_ENV'] || 'default'

ENV_CONFIG = YAML.load(File.read("features/env_profile.yml"))[profile]

CANVAS_URL = "#{ENV_CONFIG['canvas_url']}"

CANVAS_API = "#{ENV_CONFIG['canvas_url']}/api/v1"

SEN_URL = "#{ENV_CONFIG['sen_url']}/ussd/index"

CANVAS_ACCESS_TOKEN = "#{ENV_CONFIG['access_token']}"

ACCOUNT_ID = "#{ENV_CONFIG['account_id']}"

ACCOUNT_ADMIN = YAML.load(File.read("features/support/user_data.yml"))[profile]

Capybara.app_host = CANVAS_URL
Capybara.default_selector = :css
Capybara.default_driver = :webkit
Capybara.run_server = false
# Capybara.javascript_driver = :selenium_chrome
Capybara.javascript_driver = :webkit
Capybara.default_wait_time = 10
Capybara.server_boot_timeout = 50
# Capybara.reset


