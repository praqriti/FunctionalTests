Then /^User is on the Sign In page$/ do
  @app = App.new
  @app.home.load
  @app.login.wait_until_sign_in_button_visible
  @app.login.should be_displayed
end

When /^User "([^\"]*)" logs into Canvas with her credentials$/ do |identifier|
  user = @users.find{|user| user.identifier == identifier}
  @app.login.email.set "#{user.login_id}"
  @app.login.password.set "#{user.password}"
  @app.login.sign_in_button.click
end 
  
Then /^I am given an appropriate error$/ do
  @app.login.wait_until_message_box_visible
  @app.login.message_box.text.should == "Incorrect username or password."
end

Then /^"([^\"]*)" should see the Canvas home page$/ do |identifier|
  user = @users.find{|user| user.identifier == identifier}
  
  steps %{
    Then User lands on the home page
  }   
  @app.home.about_page_link.text.should == user.name
end

When /^I wait (\d+) seconds?$/ do |seconds|
  sleep seconds.to_i
end

Given /^User logs out and logs into canvas as "(.*?)"$/ do |username|
  steps %{Then User logs out
    Then User "#{username}" logs into Canvas with her credentials
    }
end

