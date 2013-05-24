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
   Given User waits for "1" seconds
   When User "enters" the status message as "#{message}"
 }
  @app.home.create_status_button.click
  retry_on_timeout do
  @app.home.wait_for_status_updated
  @app.home.should have_status_updated
end
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
   end
  sleep(2)
    @app.home.status_message.value.should_not == "#{message}"
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
  @app.home.wait_for_updated_status_message
  @app.home.should have_updated_status_message
end
  @app.home.updated_status_message.value.should == "#{message}"
end

Then /^User can navigate from alert and accept the request of "([^\"]*)"$/ do |username|
  user = @users.find{|user| user.identifier == "#{username}"}
  retry_on_timeout do
  @app.home.wait_for_connection_alert
  @app.home.should have_connection_alert
end
  @app.home.connection_alert.alert_links.find {|user_link| user_link.text == user.name}.click
  steps %{
    Then User can view the "public" wall of the user "#{user.name}"
  }
end

Then /^User must see the connection request alerts on home page:$/ do |connections_table|
   retry_on_timeout do
    @app.home.wait_for_connection_alert
    @app.home.should have_connection_alert
  end
  connections_table.hashes.each do |hash|
  requesting_friend = @users.find{|user| user.identifier == "#{hash["REQUESTING_FRIEND"]}"}
  @app.home.connection_alert.alert_links.map {|user| user.text == "#{requesting_friend.name}"}
end
end


Then /^User can navigate to the connection request page from the connection alert$/ do
  retry_on_timeout do
  @app.home.wait_for_connection_alert
  @app.home.should have_connection_alert
end
  @app.home.connection_alert.alert_links.last.click
  steps %{
    Then User can see "1" pending requests
  }
end

Then /^User does not see the connection request alert$/ do
  @app.home.load
  retry_on_timeout do
    @app.home.wait_for_connection_alert
    @app.home.should have_connection_alert
  end
  @app.home.connection_alert.should_not have_image
end




