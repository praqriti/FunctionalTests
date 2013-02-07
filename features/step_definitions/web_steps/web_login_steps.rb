Then /^User is on the Sign In page$/ do
  @app = App.new
  @app.home.load
  @app.login.should be_displayed
end

When /^User "([^\"]*)" logs into Canvas with her credentials$/ do |identifier|
  user = @users.find{|user| user.identifier == identifier}
  @app.login.email.set "#{user.login_id}"
  @app.login.password.set "#{user.password}"
  @app.login.sign_in_button.click
  
  steps %{
    Then "#{user.name}" should see the Canvas home page
    }
end 
  
Then /^I am given an appropriate error$/ do
  @app.login.wait_for_message_box
  @app.login.message_box.text.should == "Incorrect username or password."
end

Then /^"([^\"]*)" should see the Canvas home page$/ do |username|  
  retry_on_timeout do
   @app.home.should be_displayed
   @app.home.wait_for_username_link
   if (!@app.home.should have_username_link)
   @app.home.load
 end
  end
  @app.home.username_link.text.should == username
end

When /^I wait (\d+) seconds?$/ do |seconds|
  sleep seconds.to_i
end

Given /^User logs out and logs into canvas as "(.*?)"$/ do |username|
  steps %{
    Then User logs out
    Then User "#{username}" logs into Canvas with her credentials
    }
end

When /^User "(.*?)" is assigned the role of account admin$/ do |username|
  user = @users.find{|user| user.identifier == username}
  CanvasUserInterface.assign_account_admin(user)
end

Given /^Super Admin logs into Canvas$/ do
  @app = App.new
  @app.canvas_login.load
  @app.canvas_login.wait_for_sign_in_button  
  @app.canvas_login.email.set "#{SUPER_ADMIN}"
  @app.canvas_login.password.set "#{SUPER_ADMIN_PASSWORD}"
  @app.canvas_login.sign_in_button.click
  
  @app.home.username_link.text.should == SUPER_ADMIN
end

Given /^Super Admin tries to login using CAS$/ do
  steps %{
    Given User is on the Sign In page
  }
   @app.login.email.set "#{SUPER_ADMIN}"
   @app.login.password.set "#{SUPER_ADMIN_PASSWORD}"
   @app.login.sign_in_button.click
end

Then /^Super Admin must not be allowed to login$/ do
  @app.login.wait_for_sign_in_button  
  #assert on error when bug is fixed
end




