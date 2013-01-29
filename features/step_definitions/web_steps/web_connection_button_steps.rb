Then /^User can navigate and view "(.*?)" wall without a connection button$/ do |user_identifier|
  if user_identifier == "his"
    user = @logged_in_user
  else
    user = @users.find{|user| user.identifier == user_identifier}
  end
  @app.my_wall.visit_profile_page user.id
  steps %{
     Then User can view the "public" wall of the user "#{user.name}"
   }
@app.my_wall.should_not have_add_connection_button
end

Then /^User can navigate and view "(.*?)" wall with button "(.*?)"$/ do |user_identifier, button_text|
  user = @users.find{|user| user.identifier == user_identifier}
  @app.my_wall.visit_profile_page user.id
  steps %{
     Then User can view the "public" wall of the user "#{user.name}"
   }
  retry_on_timeout do
  @app.my_wall.wait_for_add_connection_button
  @app.my_wall.should have_add_connection_button
end
  @app.my_wall.add_connection_button.value.should == button_text
end

When /^User clicks on "Add Connection" button$/ do
  @app.my_wall.should have_add_connection_button
  @app.my_wall.add_connection_button.value.should == "Add Connection"
  @app.my_wall.add_connection_button.click
  @app.my_wall.wait_until_success_message_visible
  @app.my_wall.success_message.text.should == "Connection request sent"
end