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
  rescue Exception => e
   if n > 0
     p "Attempts left :#{n-1}"
     p "#{e}"
     retry_on_timeout(n - 1, &block)
  else
    raise "****Retries failed****"
  end
end

def notifications_page_reload(n = 3, &block)
  found = block.call
  if !found
    if n > 0
      puts "waiting for notifications. #{n-1} more attempts."
      @app.home.load
      notifications_page_reload(n - 1, &block)
    else
      raise "****Notification not found*****"
    end
  end
end
