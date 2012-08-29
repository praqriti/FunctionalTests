
  # require 'httparty'
  #  require "json_spec"
   require 'yaml'
   
   USER = YAML.load(File.read("features/support/user_data.yml"))
   
  require File.dirname(__FILE__) + '/hooks.rb'



# Before do
# profile = ENV['PROFILE'] || 'default'
# c = YAML.load_file("features/env_profile.yml")[profile]
# BASE_URL = "#{c['base_url']}"
# end
# 

