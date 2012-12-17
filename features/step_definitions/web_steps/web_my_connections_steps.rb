When /^User navigates to "My Connections" page$/ do
  @app.my_connections.load
  @app.my_connections.wait_until_header_message_visible 
end


Then /^User can see "(.*?)" on my connections page$/ do |username|
  user = @users.find{|user| user.identifier == username}
  @app.my_connections.username.text.should == "#{user.name}"
  @app.my_connections.should have_disconnect_button
end

Then /^User cannot see "(.*?)" on my connections page$/ do |username|
  @app.my_connections.should_not have_username
  @app.my_connections.should_not have_disconnect_button
end

Given /^User "(.*?)" is connected to:$/ do |username, users_table|
  @connected_users = []
  users_table.hashes.each do |hash|
  @connected_users << hash[:USER]
  steps %{
      And "#{username}" is connected to "#{hash[:USER]}"
  }
  sleep(1)
  end
end

Then /^User clicks on "show more" on "My Connections" page$/ do
  @app.my_connections.show_more.click
  sleep(5)
end

When /^User can "disconnect" his connection "(.*?)"$/ do |username|
  user = @users.find{|user| user.identifier == username}
  @app.my_connections.username.text.should == "#{user.name}"
  @app.my_connections.disconnect_button.click
  @app.my_connections.wait_until_dialog_visible
end


And /^User confirms the disconnection "(.*?)"$/ do |username|
  user = @users.find{|user| user.identifier == username}
  page.find("#modal_confirm_button").click
  @app.my_connections.wait_until_connection_alert_visible
  @app.my_connections.connection_alert.text.should == "#{user.name} and You are no longer connected"
  #for integration tests
  @connected_users.delete("#{user.identifier}")
end

And /^User unconfirms the disconnection$/ do
  page.find("#modal_cancel_button").click
end

Then /^User can see "(.*?)" connections available$/ do |number|
  sleep(1)
@app.my_connections.load
@app.my_connections.wait_until_header_message_visible
@app.my_connections.header_message.text.should == "#{number} Connection(s) available"
if (number!='0')
@app.my_connections.wait_for_my_connections_details
end
end

