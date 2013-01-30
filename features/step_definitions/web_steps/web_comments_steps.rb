Then /^User comments "(.*?)" on the status of "([^\"]*)"$/ do |comment, user|
  retry_on_timeout do
  @app.my_wall.wait_for_comment_box
end
  @app.my_wall.comment_box.set "#{comment}"
  @app.my_wall.comment_submit.click
end


Then /^the comment "(.*?)" by "(.*?)" is visible on users wall$/ do |comment, username|
  @app.my_wall.wait_for_comments
  @app.my_wall.comment_values.each do |actual_comment|
	actual_comment.text.should == comment
	end
  steps %{
	Then User can view her name "#{username}" on the comment
	}
end
