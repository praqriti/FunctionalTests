  require 'capybara'
  require 'capybara/dsl'
  require 'capybara/cucumber'
  require 'site_prism'

Capybara.default_selector = :css
Capybara.default_driver = :selenium 
Capybara.app_host = "http://localhost:3000/"


# require File.dirname(__FILE__) + '/hooks'


 
