Given /^User lands on the home page$/ do
  retry_on_timeout do
  @app.home.should be_displayed
  @app.home.wait_for_header
  @app.home.should have_header
  end
end

Then /^User navigates to canvas home page$/ do
  retry_on_timeout do    
    @app.home.load 
    @app.home.should be_displayed
  end
  
end

Then /^I log out of my account$/ do
  @app.home.logout_link.text.should == "Logout"
end

And /^User "updates" the status message as "([^\"]*)"$/ do |message|
 steps %{
   When User "enters" the status message as "#{message}"
 }
  @app.home.create_status_button.click
  @app.home.wait_for_status_updated

end

And /^User "enters" the status message as "([^\"]*)"$/ do |message|
  retry_on_timeout do    
    @app.home.wait_for_status_message
    @app.home.should have_status_message
  end
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
   retry_on_timeout do
    @app.home.wait_for_status
    @app.home.should have_status
    @app.home.should have_updated_status_message
    @app.home.status_message.value.should_not == "#{message}"
  end
end

Then /^User can update the status again as "([^\"]*)"$/ do |message|
  steps %{
    Then User "updates" the status message as "#{message}"
    And User status "#{message}" is updated successfully
  }
end

Then /^User logs out$/ do
  @app.home.logout_link.click
  retry_on_timeout do
  @app.login.wait_for_message
  @app.login.message.text.should == "You have successfully logged out."
  end
end

Then /^status message should be "([^\"]*)"$/ do |message|
  retry_on_timeout do
  @app.home.wait_for_status
  @app.home.should have_status
  @app.home.should have_updated_status_message
  @app.home.updated_status_message.value.should == "#{message}"
end
end


