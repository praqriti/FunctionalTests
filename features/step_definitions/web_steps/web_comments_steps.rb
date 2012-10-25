And /^User can navigate and view the wall of user "([^\"]*)"$/ do |username|
  user = @users.find{|user| user.identifier == "#{username}"}
  steps %{
  Then User navigates to search page
  Then User searches for "#{user.name}" and clicks search
  }
  @app.search.username.text.should == user.name
  @app.search.users_link.click
  @app.user_wall.wait_until_user_name_visible
  @app.user_wall.user_name.text.should == user.name
end

Then /^User comments "(.*?)" on the status of "([^\"]*)"$/ do |comment, user|
  @app.user_wall.comment_box.set "#{comment}"
  @app.user_name.comment_submit.click
end

Then /^the comment "(.*?)" is visible on the wall$/ do |comment|
  @app.user_wall.comment_text.text.should == comment
end