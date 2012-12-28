Then /^User can navigate and view "(.*?)" wall without a connection button$/ do |user_identifier|
  if user_identifier == "his"
    user_id = @logged_in_user.id
  else
    user_id = @users.find{|user| user.identifier == user_identifier}.id
  end
  @app.my_wall.visit_profile_page user_id
  @app.my_wall.wait_until_user_name_visible
  @app.my_wall.has_add_connection_button_div?.should == false
end

Then /^User can navigate and view "(.*?)" wall with button "(.*?)"$/ do |user_identifier, button_text|
  user_id = @users.find{|user| user.identifier == user_identifier}.id
  @app.my_wall.visit_profile_page user_id
  @app.my_wall.wait_until_user_name_visible
  @app.my_wall.has_add_connection_button?.should == true
  @app.my_wall.add_connection_button.value.should == button_text
end