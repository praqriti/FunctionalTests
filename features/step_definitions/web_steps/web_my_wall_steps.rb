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

Then /^User comments "(.*?)" on her status message$/ do |arg1|
  @app.my_wall.wait_until_comment_box_visible
  @app.my_wall.comment_box.set "#{arg1}"
  @app.my_wall.comment_submit.click
end

Then /^the comments are visible on My Wall$/ do |comments_table|
  @app.my_wall.wait_until_comment_box_visible
  comments_table.hashes.each do |hash|
    @app.my_wall.comment.text.should == "#{hash[:COMMENT]}"
  end
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
end



