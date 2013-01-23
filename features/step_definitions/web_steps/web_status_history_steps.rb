When /^User clicks on Show previous status messages link$/ do
  @app.my_wall.wait_for_previous_status_link
  @app.my_wall.previous_status_link.click
end

Then /^User should see previous "(.*?)" status messages$/ do |no_of_status, expected_status_message|
  @app.my_wall.wait_for_previous_status_message_details
  @app.my_wall.previous_status_message_details.size.should eql no_of_status.to_i
  index = 0
  @app.my_wall.previous_status_message_details.each do |actual_status_message|
    expected_status_message.hashes[index].has_value?(actual_status_message.text)
    index += 1
  end
end

Then /^User should see appropriate message$/ do
	@app.my_wall.wait_for_no_status_message
	sleep(3)
	@app.my_wall.no_status_message.text.should == "There are no older status messages"
end

And /^Comment Box is not present$/ do
	@app.my_wall.should_not have_comment_box
end
