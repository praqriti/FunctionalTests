Given /^User lands on the home page$/ do
  retry_on_timeout do
  @app.home.should be_displayed
   # @app.home.wait_until_header_visible
   # @app.home.wait_until_status_message_visible
  end
end

Then /^User navigates to canvas home page$/ do
  retry_on_timeout do    
    @app.home.load 
  end
  @app.home.should be_displayed
  
  # @app.home.wait_until_header_visible
  #  @app.home.wait_until_status_message_visible
end

Then /^I log out of my account$/ do
  @app.home.logout_link.text.should == "Logout"
end

And /^User "updates" the status message as "([^\"]*)"$/ do |message|
  @app.home.wait_until_status_visible
 steps %{
   When User "enters" the status message as "#{message}"
 }
  @app.home.create_status_button.click
  @app.home.wait_until_status_updated_visible

end

And /^User "enters" the status message as "([^\"]*)"$/ do |message|
  @app.home.status_message.click
  @app.home.status_message.set "#{message}"
end

Then /^User status "([^\"]*)" is updated successfully$/ do |message|
  steps %{
    Then User navigates to canvas home page
    Then status message should be "#{message}"
  }
end


Then /^User status "([^\"]*)" is not updated$/ do |message|
  @app.home.load 
  @app.home.wait_until_status_visible
   retry_on_timeout do
    @app.home.should have_updated_status_message
    @app.home.status_message.value.should_not == "#{message}"
  end
end

Then /^User can update the status again as "([^\"]*)"$/ do |message|
  steps %{
    Then User navigates to canvas home page
  }
  @app.home.status_message.click
  steps %{
    Then User "updates" the status message as "#{message}"
    And User status "#{message}" is updated successfully
  }
end

Then /^User logs out$/ do
  @app.home.logout_link.click
  retry_on_timeout do
  @app.login.message.text.should == "You have successfully logged out."
end
end

Then /^status message should be "([^\"]*)"$/ do |message|
  retry_on_timeout do
  @app.home.wait_until_status_message_visible
  @app.home.should have_updated_status_message
  @app.home.updated_status_message.value.should == "#{message}"
end
end


