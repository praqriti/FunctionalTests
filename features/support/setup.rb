profile = ENV['RAILS_ENV'] || 'default'

ENV_CONFIG = YAML.load(File.read("features/env_profile.yml"))[profile]

CANVAS_URL = "#{ENV_CONFIG['canvas_url']}"

CANVAS_API = "#{ENV_CONFIG['canvas_url']}/api/v1"

SEN_URL = "#{ENV_CONFIG['sen_url']}/ussd/index"

CANVAS_ACCESS_TOKEN = "#{ENV_CONFIG['access_token']}"

ACCOUNT_ID = "#{ENV_CONFIG['account_id']}"

RECORDS_PER_PAGE = "#{ENV_CONFIG['records_per_page']}"

Capybara.app_host = CANVAS_URL
Capybara.default_selector = :css
Capybara.default_driver = :selenium_firefox
Capybara.run_server = false
 #Capybara.javascript_driver = :selenium_chrome
Capybara.javascript_driver = :webkit
Capybara.default_wait_time = 50
Capybara.server_boot_timeout = 50
Capybara.reset_sessions!

