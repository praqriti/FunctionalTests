When /^User navigates to "My Connections" page$/ do
  @app.my_connections.load
  retry_on_timeout do
  @app.my_connections.wait_for_header_message 
  @app.my_connections.should have_header_message 
  sleep(2)
end
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

Given /^User "(.*?)" has accepted connection request from:$/ do |username, users_table|
  users_table.hashes.each do |hash|
  steps %{
      And "#{username}" has accepted connection request from "#{hash[:USER]}"
  }
  sleep(1)
  end
end

Given /^the following connections exist:$/ do |connections_table|
  connections_table.hashes.each do |hash|
  steps %{
      And "#{hash["ACCEPTING_FRIEND"]}" has accepted connection request from "#{hash["REQUESTING_FRIEND"]}"
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
  retry_on_timeout do
  @app.my_connections.wait_for_username
  @app.my_connections.should have_username
  end
  connection = @app.my_connections.my_connections_details.find { |connection| connection.username.text == user.name }     
  connection.disconnect_button.click
  @app.my_connections.wait_for_dialog
end


And /^User confirms the disconnection "(.*?)"$/ do |username|
  user = @users.find{|user| user.identifier == username}
  page.find("#modal_confirm_button").click
  @app.my_connections.wait_until_connection_alert_visible
  @app.my_connections.connection_alert.text.should == "#{user.name} and You are no longer connected"
  #for integration tests
  @connected_users.delete(user)
end

And /^User unconfirms the disconnection$/ do
  page.find("#modal_cancel_button").click
end

Then /^User can see "(.*?)" connections available$/ do |number|
steps %{
  When User navigates to "My Connections" page
}
@app.my_connections.header_message.text.should == "#{number} Connection(s) available"
end

Then /^User chooses the user "(.*?)"$/ do |number|
  steps %{
   Then User replies with option "1"
	}
end



