Then /^I am on the Sign In page$/ do
  @app = App.new
  
  @app.login.load
  @app.login.wait_until_sign_in_button_visible
  @app.login.should be_displayed
  @app.login.current_url.should include "/cas/login?service"
end


When /^I enter my login_id "([^\"]*)" and password "([^\"]*)"$/ do |login_id,password|
  @app.login.email.set "#{login_id}"
  @app.login.password.set "#{password}"
  @app.login.sign_in_button.click
end 
  
Then /^I am given an appropriate error$/ do
  @app.login.wait_until_message_box_visible
  @app.login.message_box.text.should == "Incorrect username or password."
end

Then /^"([^\"]*)" should be successfully logged into canvas$/ do |login_id|
  steps %{
    Then User lands on the home page
  }   
  @app.home.about_page_link.text.should == login_id
end

