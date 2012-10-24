Given /^User "(.*?)" has pending connection requests from:$/ do |user,users_table|
  users_table.hashes.each do |hash|  
  steps %{
     When User is on the Sign In page
     And User "#{hash[:USER]}" logs into Canvas with her credentials
     Then "#{hash[:USER]}" should see the Canvas home page
     And User navigates to search page
     When User searches for "#{user}" and clicks search
     And User adds the user "#{user}" as a connection
     Then User logs out
  }
  end
end

When /^User navigates to "Connection Requests"$/ do
  @app.connection_requests.load
  @app.connection_requests.wait_until_header_message_visible
end

Then /^User can see the pending connection requests sent from:$/ do |users_table|
  users_table.hashes.each do |hash|  
 @app.connection_requests.username.text.should == "#{hash[:USER]}"
 @app.connection_requests.should have_accept_button
 @app.connection_requests.should have_reject_button  
 end
end

Then /^User can view the connection requests in alphabetical order$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^User can "(.*?)" the connection request from "(.*?)"$/ do |user_action, username|
  @app.connection_requests.header_message.text.should == "1 Pending Request(s)"
  
  if(user_action == 'accept')  
    @app.connection_requests.accept_button.click 
    @app.connection_requests.wait_until_connection_alert_visible
    @app.connection_requests.connection_alert.text.should == "#{username} and You are now connected"
  end
  if(user_action == 'reject')
    @app.connection_requests.reject_button.click 
    @app.connection_requests.wait_until_connection_alert_visible
    @app.connection_requests.connection_alert.text.should == "#{username} and You are no longer connected"
  end
end

Then /^User can see the "(.*?)" pending requests$/ do |number|
@app.connection_requests.load
@app.connection_requests.wait_until_header_message_visible
@app.connection_requests.header_message.text.should == "#{number} Pending Request(s)"
end



