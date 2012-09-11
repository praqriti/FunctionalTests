require 'bundler'
Bundler.require
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'site_prism'
require 'yaml'
require 'pry'
# ENVIRONMENT = YAML.load(File.read("features/env_profile.yml"))['default']
