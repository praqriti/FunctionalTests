
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
  @app.connection_requests.header_message.text.should == "0 Pending Request(s)"
end

When /^User navigates to my connections page$/ do
  @app.my_connections.load
  @app.my_connections.wait_until_header_message_visible 
end


Then /^User can see "(.*?)" on my connections page$/ do |username|
  @app.my_connections.username.text.should == "#{username}"
  @app.my_connections.should have_disconnect_button
end

Then /^User cannot see "(.*?)" on my connections page$/ do |username|
  @app.my_connections.should_not have_username
  @app.my_connections.should_not have_disconnect_button
end
