When /^User clicks on Show previous status messages link$/ do
  @app.my_wall.previous_status_link.click
end

Then /^User should see the previous statuses link$/ do
  @app.my_wall.should have_previous_status_link
end

Then /^User should see previous 5 status messages$/ do |expected_status_message|
  @app.my_wall.wait_until_previous_status_message_details_visible
  @app.my_wall.previous_status_message_details.size.should eql 5
  index = 0
  @app.my_wall.previous_status_message_details.each do |actual_status_message|
    expected_status_message.hashes[index].has_value?(actual_status_message.text)
    index += 1
  end
end