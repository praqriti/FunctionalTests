# Register a specific selenium driver for firefox
Capybara.register_driver :selenium_firefox do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

# Allows the use of a tag @selenium_firefox before a scenario to run it in selenium with firefox
# Before('@selenium_firefox') do
  # Capybara.current_driver = :selenium_firefox
# end
