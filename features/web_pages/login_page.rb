Then /^I am on the 'Sign In' page$/ do
  @signin_page = SignIn.new
  @signin_page.load
  @signin_page.wait_until_sign_in_button_visible
  @signin_page.should be_displayed
  @signin_page.current_url.should include "/cas/login?service"
  # @signin_page.should have_remember_me
end


When /^I enter my login_id "([^\"]*)" and password "([^\"]*)"$/ do |login_id,password|
  @signin_page.email.set "#{login_id}"
  @signin_page.password.set "#{password}"
  @signin_page.sign_in_button.click
end 
  
Then /^"([^\"]*)" should be successfully logged into canvas$/ do |login_id|
  @signin_page.wait_until_about_page_link_visible
  @signin_page.about_page_link.text.should == login_id
end

Then /^I am given an appropriate error$/ do
  @signin_page.wait_until_message_box_visible
  # @signin_page.message_box.text.should == "error"
end

Then /^I log out of my account$/ do
  @signin_page.logout_link.text.should == "Logout"
  @signin_page.wait_until_message_box_visible
end