Given /^User lands on My Wall and can view all the elements$/ do
    retry_on_timeout do
       @app.my_wall.wait_for_user_name
       @app.my_wall.should have_user_name
       @app.my_wall.should have_birthdate
       @app.my_wall.should have_language
       @app.my_wall.should have_time_zone
    end 
end

Given /^User clicks on My Wall$/ do
  @app.home.menu.should have_my_wall
  @app.home.menu.my_wall.click
  steps %{
    Then User lands on My Wall and can view all the elements
  }
end

Then /^User should see his location on my wall as "(.*?)"$/ do |location|
  steps %{
    Then User should see the location as "#{location}"
  }
end

Then /^User can view her latest status message "(.*?)"$/ do |message|
  retry_on_timeout do
  @app.my_wall.wait_for_status_message
  @app.my_wall.should have_status_message
    sleep(2)
end
  @app.my_wall.status_message.text.should == message
end


Then /^User can view her name "(.*?)" on the comment$/ do |username|
  user = @users.find{|user| user.identifier == username}
  @app.my_wall.wait_for_commented_by
  @app.my_wall.should have_commented_by
  @app.my_wall.commented_by.text.should == "#{user.name}"
end

And /^User can view the timestamp on the status$/ do
	@app.my_wall.should have_timestamp_status
end

And /^User can view the timestamp on the comment$/ do
	@app.my_wall.should have_commented_at
end

Then /^User comments "(.*?)" on her status message$/ do |arg1|
  retry_on_timeout do
  @app.my_wall.wait_for_comment_box
  @app.my_wall.should have_comment_box
end

  initial_comment_count = @app.my_wall.comments.size
  @app.my_wall.comment_box.set "#{arg1}"
  @app.my_wall.comment_submit.click
  
  retry_on_timeout do
	sleep(2)
	@app.my_wall.should have(initial_comment_count+1).comments
end
end

Then /^the comments are visible on My Wall in order of the date$/ do |comments_table|  
  expected_comments = comments_table.hashes.collect{|x| x["COMMENT"]}
  
  retry_on_timeout do
    @app.my_wall.wait_for_comments(expected_comments.size)
    @app.my_wall.should have(expected_comments.size).comments
  end	
  @app.my_wall.comment_values.map {|comment| comment.text }.should == expected_comments
end
   
Then /error message "(.*?)" is displayed$/ do |error1|
  @app.my_wall.wait_until_error_message_visible
  @app.my_wall.error_message.text.should == error1
end

Then /^User cannot enter blank comment on the status$/ do
retry_on_timeout do
  @app.my_wall.wait_for_comment_box
  @app.my_wall.should have_comment_box
end
  @app.my_wall.comment_box.set ""
  @app.my_wall.comment_submit.click
  steps %{
    Then error message "Can not post an empty comment. Please re-enter comment before posting" is displayed
  }
end

Then /^User comments on her status message:$/ do |string|
  retry_on_timeout do
  @app.my_wall.wait_for_comment_box
  @app.my_wall.should have_comment_box
end
  @app.my_wall.comment_box.set "#{string}"
  @app.my_wall.comment_submit.click
end

Then /^the common connections box "(.*?)" visible$/ do |arg1|
  if arg1.include? "not"
    @app.my_wall.should_not have_common_connections
  else
    retry_on_timeout do
    @app.my_wall.wait_for_common_connections
    @app.my_wall.should have_common_connections
    end
  end
end

Then /^User can see "(.*?)" on the common connections sidebar$/ do |username|
  user = @users.find{|user| user.identifier == username}
  retry_on_timeout do
   @app.my_wall.wait_for_common_connections
   @app.my_wall.should have_common_connections
   end
  @app.my_wall.common_connections.collect do |common_connection|
    common_connection.text.include? "#{user.name}"
    common_connection.should have_connection_image
  end
end

Then /^User can navigate to the "(.*?)" wall of "(.*?)" from the common connections sidebar$/ do |authorisation,username|
  user = @users.find{|user| user.identifier == username}
  retry_on_timeout do
  @app.my_wall.wait_for_common_connections
  @app.my_wall.should have_common_connections
  end
  @app.my_wall.common_connections.first.connection_wall.click
  @app.my_wall.wait_for_user_name
  @app.my_wall.should have_user_name
  @app.my_wall.user_name.text.should == "#{user.name}"
  @app.my_wall.should have_status_with_comments if authorisation == "private"
  @app.my_wall.should_not have_status_with_comments if authorisation == "public"
end

Then /^the sidebar has "(.*?)" common connections$/ do |size|
  @app.my_wall.common_connections.size.to_s.should == size
end


And /^User can navigate and view the "([^\"]*)" wall of user "([^\"]*)"$/ do |view,username|    
  user = @users.find{|user| user.identifier == "#{username}"}
  @app.my_wall.visit_profile_page user.id
  steps %{
    Then User can view the "#{view}" wall of the user "#{user.name}"
  }
end

Then /^User should see the location as "(.*?)"$/ do |location|
  @app.my_wall.location.text.should == location
end

Then /^User can view the "([^\"]*)" wall of the user "([^\"]*)"$/ do |view,username|
  retry_on_timeout do
   @app.my_wall.wait_for_user_name
   @app.my_wall.should have_user_name
  end
   @app.my_wall.user_name.text.should == "#{username}"
   @app.my_wall.should have_status_with_comments if view == "private"
   @app.my_wall.should_not have_status_with_comments if view == "public"
end

Then /^User can navigate and view "(.*?)" wall without a connection button$/ do |user_identifier|
  if user_identifier == "his"
    user = @logged_in_user
  else
    user = @users.find{|user| user.identifier == user_identifier}
  end
  steps %{
     Then User can navigate and view the "public" wall of user "#{user.identifier}"
   }
@app.my_wall.should_not have_add_connection_button
end

Then /^User can navigate and view "(.*?)" wall with button "(.*?)"$/ do |user_identifier, button_text|
  user = @users.find{|user| user.identifier == user_identifier}
  steps %{
     Then User can navigate and view the "public" wall of user "#{user.identifier}"
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

Given /^User "(.*?)" and "(.*?)" have "(.*?)" common connections$/ do |user1,user2,connections|
  steps %{
   Given the following users exists in canvas:
    |USER|
    |#{user1}|
    |#{user2}|
  }
  for i in 1..connections.to_i  
  friend = "camfed_friend_"+"#{i}"
  steps %{
    Given the following users exists in canvas:
    |USER|
    |#{friend}|
    And "#{user1}" has accepted connection request from "#{friend}"
    And "#{user2}" has accepted connection request from "#{friend}"
  }
end
end



Given /^User "(.*?)" and "(.*?)" have the following common connections:$/ do |user1, user2, connections_table|
   steps %{
     Given the following users exists in canvas:
      |USER|
      |#{user1}|
      |#{user2}|
    }
   connections_table.hashes.each do |hash|
    steps %{
      Given the following users exists in canvas:
      |USER|
      |#{hash["COMMON_CONNECTIONS"]}|
      And "#{user1}" has accepted connection request from "#{hash["COMMON_CONNECTIONS"]}"
      And "#{user2}" has accepted connection request from "#{hash["COMMON_CONNECTIONS"]}"
    }
  end
end

Then /^User can view the common connections:$/ do |table|
  table.hashes.each do |hash|
 steps %{
   Then User can see "#{hash["COMMON_CONNECTIONS"]}" on the common connections sidebar
 }
 end
end






