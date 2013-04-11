Then /^User should see ordered pending requests on page "([^\"]*)"$/ do |page_no|
  actual_response = @last_response.parsed_response
  page_no = page_no.to_i
  rpp = "#{RECORDS_PER_PAGE}".to_i
  start_index = rpp * (page_no-1)
  end_index = start_index + (rpp-1)
    
  @requesters.reverse[start_index..end_index].each do |requester|
    actual_response["message"].include?(requester.name.truncate 20).should == true
  end

  actual_response["message"].include?("0 Previous Menu").should == true

  steps %{
		Then the JSON at "session_id" should be "#{@session_id}"
		Then the JSON at "session_type" should be "SESSION"

		}
end

Then /^User should see the message "([^\"]*)" with "([^\"]*)"$/ do |message, name|
  user = @users.find{|user| user.identifier == name}
  expected_message = @messages.get(message, ["#{user.name[0..16]}..."])
  steps %{
	Then the JSON at "message" should be "#{expected_message}"
	Then the JSON at "session_id" should be "#{@session_id}"
	Then the JSON at "session_type" should be "SESSION"

	}
  @requesters.delete(user)
end

Then /^User should see the notice "([^\"]*)" with "([^\"]*)"$/ do |message, name|
  user = @users.find{|user| user.identifier == name}
  expected_message = @messages.get(message, ["#{user.name[0..16]}..."])
  actual_response = @last_response.parsed_response
  actual_response["message"].include?(expected_message).should == true
  actual_response["message"].include?(@messages.get("previous_menu_option")).should == true

  steps %{
	Then the JSON at "session_id" should be "#{@session_id}"
	Then the JSON at "session_type" should be "SESSION"

	}
  @requesters.delete(user)
end

Then /^User should see connection response options$/ do
  body = @last_response.parsed_response
  body["message"].should eql @messages.get("connection_response_options")
end

When /^User chooses "Accept" option$/ do
  steps %{
   Then User replies with option "1"
	}
end

When /^User chooses "Reject" option$/ do
  steps %{
   Then User replies with option "2"
	}
end
