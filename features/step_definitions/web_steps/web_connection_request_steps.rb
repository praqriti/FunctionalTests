Given /^User "(.*?)" has pending connection requests from:$/ do |username, users_table|
  users_table.hashes.each do |hash|
	steps %{
		And "#{hash[:USER]}" has sent connection request to "#{username}"
  }
  sleep(1)
  end
end

When /^User navigates to "Connection Requests"$/ do
  sleep(1)
  @app.connection_requests.load
  retry_on_timeout do
  @app.connection_requests.wait_for_users
  @app.connection_requests.should have_users
end
end

Then /^User can see the pending connection requests sent from:$/ do |users_table|
	users_table.hashes.each do |hash|  
		user = @users.find{|user| user.identifier == hash[:USER]}
		@app.connection_requests.username.text.should == "#{user.name}"
		@app.connection_requests.should have_accept_button
		@app.connection_requests.should have_reject_button
	end
end

Then /^User has "(.*?)" pending connection requests$/ do |requests|
   for i in 1..requests.to_i  
    friend = "camfed_requesting_friend_"+"#{i}"
    steps %{
      Given the following users exists in canvas:
      |USER|
      |#{friend}|
      And "#{friend}" has sent connection request to "camfed_user"
    }
  end
end

Then /^User can "(.*?)" the connection request from "(.*?)"$/ do |user_action, username|
  user = @users.find{|user| user.identifier == username}
  steps %{
		Then User can see "1" pending requests
	}
	if(user_action == 'accept')  
		@app.connection_requests.accept_button.click 
		@app.connection_requests.wait_until_connection_alert_visible
		@app.connection_requests.connection_alert.text.should == "#{user.name} and You are now connected"
	end
  if(user_action == 'reject')
    @app.connection_requests.reject_button.click 
    @app.connection_requests.wait_until_connection_alert_visible
    @app.connection_requests.connection_alert.text.should == "#{user.name} and You are no longer connected"
  end
end

Then /^User can see "(.*?)" pending requests$/ do |number|
  sleep(1)
	@app.connection_requests.load
	@app.connection_requests.wait_for_header_message
	@app.connection_requests.header_message.text.should == "#{number} Pending Request(s)"
	if(number!='0')
		@app.connection_requests.wait_for_connection_details
	end
end

Given /^User "(.*?)" has pending connection requests from "(.*?)" users$/ do |username, user_count|
	(1..user_count.to_i).each do |i|
		@users << User.create("dummy_user_#{i}_")
		current_user = @users.last
    steps %{
			And "#{current_user.identifier}" has sent connection request to "#{username}"
		}
		sleep 1
    p "pending request created by user #{current_user.login_id}"
	end
end

Given /^User "(.*?)" has connections from "(.*?)" users$/ do |username, user_count|
	(1..user_count.to_i).each do |i|
		@users << User.create("dummy_user_#{i}_")
		current_user = @users.last
    steps %{
			And "#{current_user.identifier}" has accepted connection request from "#{username}"
		}
		sleep 1
		p "connection created by user #{current_user.login_id}"
  end
end

Then /^User can view "(.*?)" connection requests on "Connections Requests" page$/ do |request_count|
	@app.connection_requests.users.size.should == request_count.to_i
end

Then /^User can view "(.*?)" connections on "My Connections" page$/ do |request_count|
	@app.my_connections.users.size.should == request_count.to_i
end

Then /^User clicks on "show more" on "Connections Requests" page$/ do
  @app.connection_requests.show_more.click
  sleep(5)
end


When /^User rejects a connection request from page "(.*?)"$/ do |user_count|
  @app.connection_requests.connection_details.last.reject_button.click
  @app.connection_requests.wait_for_connection_alert
end

When /^User accepts a connection request from page "(.*?)"$/ do |user_count|
  @app.connection_requests.connection_details.last.accept_button.click
  @app.connection_requests.wait_for_connection_alert
end

And /^"(.*?)" has sent connection request to "(.*?)"$/ do |user_identifier, friend_identifier|
  user1 = @users.find{|user| user.identifier == user_identifier}
  friend1 = @users.find{|user| user.identifier == friend_identifier}
  ConnectionsInterface.send_connection_request(user1, friend1)
  @requesters << @users.find{|user| user.identifier == user_identifier}
end

And /^"(.*?)" has accepted connection request from "(.*?)"$/ do |user_identifier, friend_identifier|
  user1 = @users.find{|user| user.identifier == user_identifier}
  friend1 = @users.find{|user| user.identifier == friend_identifier}
  ConnectionsInterface.create_connection(user1, friend1)
  @connected_users << @users.find{|user| user.identifier == friend_identifier}
end

And /^User disconnects a connection$/ do
  @app.my_connections.disconnect_button.click
  @app.my_connections.wait_for_dialog
  page.find("#modal_confirm_button").click
  @app.my_connections.wait_for_connection_alert
end

Then /^User should see connection requests from:$/ do |users_table|
  users_table.hashes.each do |hash|
    user_identifier = hash[:USER]
    user = @users.find{|user| user.identifier == user_identifier}
    messages = @app.home.global_messages
    messages.collect{|c| c.text}.select{|m| m.include?(user.name)}.count.should == 1
  end
end

