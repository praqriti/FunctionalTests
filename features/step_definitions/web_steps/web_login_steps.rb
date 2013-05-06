Then /^User is on the Sign In page$/ do
  @app = App.new
  @app.home.load
  @app.login.should be_displayed
end

When /^User visits the account page$/ do
  Account.set_page_url ACCOUNT_ID
  @app.account.load
end

Then /^User chooses to add a new user to the account$/ do
  @app.account.add_user_button.click
end

Then /^User should see the add user dialog$/ do
  @app.account.wait_for_add_user
end

Then /^User enters the name for user "(.*?)"$/ do |user|
  @app.account.add_user.full_name.set user
end

Then /^User enters the email for user "(.*?)"$/ do |email|
  @app.account.add_user.email.set email
end

Then /^User enters the login for user "(.*?)"$/ do |login|
  @app.account.add_user.login.set login
end

Then /^User chooses the country for user "(.*?)"$/ do |country|
  @app.account.add_user.country.select(country)
  sleep 1
end

Then /^User chooses the district for user "(.*?)"$/ do |district|
  @app.account.add_user.district.select(district)
end

Then /^User confirms the creation$/ do
  @app.account.add_user.send_email?.click
  @app.account.add_user.submit_button.click
end

Then /^User should see success message for creating user$/ do
  @app.account.wait_for_success_message
end

Then /^User navigates to page of "(.*?)"$/ do |name|
  @app.account.user_link.click
  3.times do
    visit(current_path) and sleep(1) if @app.canvas_user_profile.name.nil?
  end
  @app.canvas_user_profile.wait_for_name
end

Then /^User has name set for "(.*?)"$/ do |username|
  user = @users.find{|user| user.identifier == username}
  @app.canvas_user_profile.name.text.should == user.name
end

Then /^User has location set to "(.*?)"$/ do |location|
  @app.canvas_user_profile.location.text.should == location
end

Then /^admin creates the user:$/ do |users_table|
  users_table.hashes.each do |hash|
    user = User.new(hash["NAME"], :country => hash["COUNTRY"], :district => hash["DISTRICT"], :email => "email"+"#{1 + rand(10000000)}")
    steps %{
      Then User enters the name for user "#{user.name}"
      Then User enters the email for user "#{user.email}"
      Then User enters the login for user "#{user.login_id}"
      Then User chooses the country for user "#{hash["COUNTRY"]}"
      Then User chooses the district for user "#{hash["DISTRICT"]}"
      Then User confirms the creation
    }
    @users << user
  end
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




