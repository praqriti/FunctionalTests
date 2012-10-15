require 'bundler'
Bundler.require
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'capybara/webkit'
require 'site_prism'
require 'yaml'
require 'pry'
require 'selenium-webdriver'
require File.expand_path(File.dirname(__FILE__) + "/canvas_user_interface")


After('@leave_the_window_open') do |scenario|
  if scenario.respond_to?(:status) && scenario.status == :failed
    print "Step Failed. Press return to close browser"
    STDIN.getc
  end
end

# @default_user = CanvasUserInterface.create_user("camfed_student")
# 
# at_exit do 
#   CanvasUserInterface.delete_user(DEFAULT_USER)
# end

