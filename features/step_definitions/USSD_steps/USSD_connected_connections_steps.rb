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
		Then the JSON at "session_id" should be "session id"
		Then the JSON at "session_type" should be "SESSION"
		Then the JSON should have "access_token"
		}
end

Then /^User should see the current status of "([^\"]*)"$/ do |username|
  user = @users.find{|user| user.identifier == username}
  message =   @statuses_to_clean.find{|status| status.user.id == user.id }.message
  steps %{
 		Then the JSON at "message" should be "#{message}\\n* Back to My Connections"
 		}
end

Then /^User should see the current status of "([^\"]*)" truncated at 100 characters$/ do |username|
  message = "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567..."
  user = @users.find{|user| user.identifier == username}
  steps %{
 		Then the JSON at "message" should be "#{message}\\n* Back to My Connections"
 		}
end

Then /^User should see the empty status of "([^\"]*)"$/ do |username|
  steps %{
  		Then the JSON at "message" should be " \\n* Back to My Connections"
  		}
end
