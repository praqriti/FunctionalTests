Then /^User should see the list of connected users for page "([^\"]*)"$/ do |page_no|
  actual_response = @last_response.parsed_response
  page_no = page_no.to_i
  rpp = "#{RECORDS_PER_PAGE}".to_i
  s_no = (rpp * (page_no-1)) + 1
  start_index = rpp * (page_no-1)
  end_index = start_index + (rpp-1)
  @connected_users.reverse[start_index..end_index].each do |connected_user|
    actual_response["message"].include?(connected_user.name.truncate 20).should == true
  end
  actual_response["message"].include?("0 Home").should == true
  steps %{
		Then the JSON at "session_id" should be "#{@session_id}"
		Then the JSON at "session_type" should be "SESSION"

		}
end

Then /^User should see the current status of "([^\"]*)"$/ do |username|
  user = @users.find{|user| user.identifier == username}
  message =   @statuses_to_clean.find{|status| status.user.id == user.id }.message
  @last_response.parsed_response["message"].index(message).should == 0
end

Then /^User should see the current status of "([^\"]*)" truncated with char limit$/ do |username|
  message = "12345678901234567890123456789012345678901234567890123456789012345678901234567..."
  user = @users.find{|user| user.identifier == username}
  @last_response.parsed_response["message"].index(message).should == 0
end

Then /^User should see the empty status of "([^\"]*)"$/ do |username|
  @last_response.parsed_response["message"].index(/\s*\n/).should == 0
end

Then /^User should see "(.*?)"$/ do |arg1|
  @last_response.parsed_response["message"].include?(arg1)
end