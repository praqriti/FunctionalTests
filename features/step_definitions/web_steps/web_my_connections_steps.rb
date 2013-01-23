When /^User navigates to "My Connections" page$/ do
  @app.my_connections.load
  @app.my_connections.wait_for_header_message 
end

Then /^User can see "(.*?)" on my connections page$/ do |username|
  user = @users.find{|user| user.identifier == username}
  connection = @app.my_connections.username.select {|c| c.text == user.name}
  connection.size.should == 1
  connection[0].parent.find(".delete")
end

Then /^User cannot see "(.*?)" on my connections page$/ do |username|
  @app.my_connections.should_not have_username
  @app.my_connections.should_not have_disconnect_button
end

Given /^User "(.*?)" is connected to:$/ do |username, users_table|
  users_table.hashes.each do |hash|
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
  connection = @app.my_connections.username.select {|c| c.text == user.name}
  connection.size.should == 1
  connection[0].parent.find(".delete").click()
  @app.my_connections.wait_for_dialog
end


And /^User confirms the disconnection "(.*?)"$/ do |username|
  user = @users.find{|user| user.identifier == username}
  page.find("#modal_confirm_button").click
  @app.my_connections.wait_for_connection_alert
  @app.my_connections.connection_alert.text.should == "#{user.name} and You are no longer connected"
  #for integration tests
  @connected_users.delete(user)
end

And /^User unconfirms the disconnection$/ do
  page.find("#modal_cancel_button").click
end

Then /^User can see "(.*?)" connections available$/ do |number|
  sleep(1)
@app.my_connections.load
@app.my_connections.wait_for_header_message
@app.my_connections.header_message.text.should == "#{number} Connection(s) available"
if (number!='0')
@app.my_connections.wait_for_my_connections_details
end
end

