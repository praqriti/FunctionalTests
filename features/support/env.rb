  require 'capybara'
  require 'capybara/dsl'
  require 'capybara/cucumber'
  require 'site_prism'
  require 'yaml'
  
require File.dirname(__FILE__) + '/hooks.rb'
USER = YAML.load(File.read("features/support/user_data.yml"))
  
Capybara.default_selector = :css
Capybara.default_driver = :selenium_firefox 
# Capybara.javascript_driver = :selenium_chrome

# require File.dirname(__FILE__) + '/../lib/configuration';
# BASE_URL = Configuration["base_url"]

# require File.dirname(__FILE__) + '/hooks'

Before do
profile = ENV['PROFILE'] || 'default'
c = YAML.load_file("features/env_profile.yml")[profile]
Capybara.app_host = "#{c['base_url']}"
end

 
 
 

 
