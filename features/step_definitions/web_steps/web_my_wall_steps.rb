Given /^User lands on My Wall and can view all the elements$/ do
  my_wall = Wall.new
  my_wall.wait_until_user_name_visible
end

Given /^User clicks on My Wall$/ do
  @app.home.menu.my_wall.click
  steps %{
    Then User lands on My Wall and can view all the elements
  }
end

Then /^User can view her latest status message "(.*?)"$/ do |arg1|
  @app.my_wall.status_message.text.should == arg1
end


Then /^User can view her name "(.*?)" on the comment$/ do |username|
  user = @users.find{|user| user.identifier == username}
  @app.my_wall.commented_by.text.should == "#{user.name}"
end

And /^User can view the timestamp on the status$/ do
	@app.my_wall.should have_timestamp_status
end

And /^User can view the timestamp on the comment$/ do
	@app.my_wall.should have_commented_at
end

Then /^User comments "(.*?)" on her status message$/ do |arg1|
  @app.my_wall.wait_until_comment_box_visible
  @app.my_wall.comment_box.set "#{arg1}"
  @app.my_wall.comment_submit.click
	@app.my_wall.wait_until_comments_visible
	@app.my_wall.wait_until_comment_box_visible
end

Then /^the comments are visible on My Wall$/ do |comments_table|
  # @app.my_wall.wait_until_comment_box_visible
	expected_comments = comments_table.hashes.collect{|x| x["COMMENT"]}
	actual_comments = @app.my_wall.comments.collect(&:text)
	expected_comments.sort.should == actual_comments.sort	
end

Then /error message "(.*?)" is displayed$/ do |error1|
  @app.my_wall.wait_until_error_message_visible
  @app.my_wall.error_message.text.should == error1
end

Then /^User cannot enter blank comment on the status$/ do
  @app.my_wall.comment_box.set ""
  @app.my_wall.comment_submit.click
  steps %{
    Then error message "Can not post an empty comment. Please re-enter comment before posting" is displayed
  }
end

Then /^User comments on her status message:$/ do |string|
  @app.my_wall.comment_box.set "#{string}"
  @app.my_wall.comment_submit.click
  @app.my_wall.wait_until_comment_box_visible
end

Then /^The Common Connections box "(.*?)" visible$/ do |arg1|
  if arg1.include? "not"
    @app.my_wall.should_not have_common_connections
  else
    @app.my_wall.should have_common_connections
  end
end



