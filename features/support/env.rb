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


After('@leave_the_window_open') do |scenario|
  if scenario.respond_to?(:status) && scenario.status == :failed
    print "Step Failed. Press return to close browser"
    STDIN.getc
  end
end

def retry_on_timeout(n = 3, &block)
  block.call
rescue Capybara::TimeoutError, Capybara::ElementNotFound => e
  if n > 0
    puts "Catched error: #{e.message}. #{n-1} more attempts."
    retry_on_timeout(n - 1, &block)
  else
    raise
  end
end

def notifications_page_reload(n = 3, &block)
  found = block.call
  if !found
    if n > 0
      @app.home.load
      notifications_page_reload(n - 1, &block)
    else
      raise "notification not found"
    end
  end
end