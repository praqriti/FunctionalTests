require 'bundler'
Bundler.require
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'site_prism'
require 'yaml'
require 'pry'
# ENVIRONMENT = YAML.load(File.read("features/env_profile.yml"))['default']

$: << File.join(File.dirname(__FILE__), '../..')

# require 'features/support/setup'
# 
# require 'features/support/json_spec_interface'
# 
# require 'features/support/canvas_user_interface'
#   