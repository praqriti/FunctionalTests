When /^User navigates to "My Connections" page$/ do
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

Given /^User "(.*?)" is connected to:$/ do |user, users_table|
  users_table.hashes.each do |hash|  
  steps %{
     When User is on the Sign In page
     And User "#{hash[:USER]}" logs into Canvas with her credentials
     Then "#{hash[:USER]}" should see the Canvas home page
     And User navigates to search page
     When User searches for "#{user}" and clicks search
     And User adds the user "#{user}" as a connection
     Then User logs out
     When User is on the Sign In page
     And User "camfed_student" logs into Canvas with her credentials
     Then "camfed_student" should see the Canvas home page
     When User navigates to "Connection Requests"
     And User can see the pending connection requests sent from:
     |USER|
     |#{hash[:USER]}|
     Then User can "accept" the connection request from "requesting_user"
  }
  end
end


When /^User can "disconnect" his connection "(.*?)"$/ do |username|
  @app.my_connections.username.text.should == "#{username}"
  @app.my_connections.header_message.text.should == "1 Connection(s) available"  
  page.evaluate_script('window.confirm = function() { return true; }')
  
  @app.my_connections.disconnect_button.click
  # handle_js_confirm(true)
  @app.my_connections.connection_alert.text.should == "#{username} and You are no longer connected"
end

Then /^User can see the "(.*?)" connections available$/ do |number|
@app.my_connections.load
@app.connection_requests.wait_until_header_message_visible
@app.my_connections.header_message.text.should == "#{number} Connection(s) available"
end


def handle_js_confirm(accept=true)
  page.evaluate_script "window.original_confirm_function = window.confirm"
   page.evaluate_script "window.confirm = function(msg) { return #{!!accept}; }"
 #   yield
 # ensure
 #   page.evaluate_script "window.confirm = window.original_confirm_function"
 # 
end

