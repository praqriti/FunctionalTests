And /^User can navigate and view the wall of user "([^\"]*)"$/ do |username|
  user = @users.find{|user| user.identifier == "#{username}"}
  steps %{
  Then User navigates to search page
  Then User searches for "#{username}" and clicks search
  }
  @app.search.username.text.should == user.name
  @app.search.users_link.click
  @app.my_wall.wait_until_user_name_visible
  @app.my_wall.user_name.text.should == "#{user.name}"
end

Then /^User comments "(.*?)" on the status of "([^\"]*)"$/ do |comment, user|
  @app.my_wall.comment_box.set "#{comment}"
  @app.my_wall.comment_submit.click
end


Then /^the comment "(.*?)" by "(.*?)" is visible on users wall$/ do |comment, username|
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
  Then User navigates to search page
  Then User searches for "#{username}" and clicks search
  }
  @app.search.username.text.should == user.name
  @app.search.users_link.click
  @app.my_wall.wait_until_user_name_visible
  @app.my_wall.user_name.text.should == "#{user.name}"
  @app.my_wall.should have_status_with_comments if view == "private"
  @app.my_wall.should_not have_status_with_comments if view == "public"
end
