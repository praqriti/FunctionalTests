Given /^User lands on the home page$/ do
  steps %{
    And I wait 10 seconds
  }
   #@app.redirect.load
   #@app.home.load
   @app.home.wait_until_status_message_visible
   @app.home.all_there?
end

Then /^User navigates to canvas home page$/ do
  #@app.redirect.load
  #@app.home.load

end

Then /^I log out of my account$/ do
  @app.home.logout_link.text.should == "Logout"
  @app.home.wait_until_message_box_visible
end

And /^User "updates" the status message as "([^\"]*)"$/ do |message|
 steps %{
   When User "enters" the status message as "#{message}"
 }
  @app.home.create_status_button.click
end

And /^User "enters" the status message as "([^\"]*)"$/ do |message|
  @app.home.status_message.click
  @app.home.status_message.set "#{message}"
end

Then /^User status "([^\"]*)" is updated successfully$/ do |message|
  steps %{
    Then User navigates to canvas home page
  }
  @app.home.status_message.value.should == "#{message}"
end


Then /^User status "([^\"]*)" is not updated$/ do |message|
   @app.home.status_message.value.should_not == "#{message}"
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
    steps %{
      Then I am on the Sign In page
    }
end



