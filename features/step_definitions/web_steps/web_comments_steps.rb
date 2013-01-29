Then /^User comments "(.*?)" on the status of "([^\"]*)"$/ do |comment, user|
  retry_on_timeout do
  @app.my_wall.wait_for_comment_box
end
  @app.my_wall.comment_box.set "#{comment}"
  @app.my_wall.comment_submit.click
end


Then /^the comment "(.*?)" by "(.*?)" is visible on users wall$/ do |comment, username|
  @app.my_wall.wait_for_comments
  @app.my_wall.comments.each do |actual_comment|
		actual_comment.text.should == comment
	end
  steps %{
	Then User can view her name "#{username}" on the comment
	}
end

And /^User can navigate and view the "([^\"]*)" wall of user "([^\"]*)"$/ do |view,username|
  user = @users.find{|user| user.identifier == "#{username}"}
  steps %{
  Then User searches for "#{username}" and clicks search
  }
  @app.search.wait_for_username
  @app.search.username.text.should == user.name
  @app.search.users_link.click
  steps %{
    Then User can view the "#{view}" wall of the user "#{user.name}"
  }
 
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
