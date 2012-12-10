Then /^User should see the list of connected users for page "([^\"]*)"$/ do |page_no|
  actual_response = @last_response.parsed_response
  page_no = page_no.to_i
  rpp = "#{RECORDS_PER_PAGE}".to_i
  s_no = (rpp * (page_no-1)) + 1
  start_index = rpp * (page_no-1)
  end_index = start_index + (rpp-1)

  @connected_users.reverse[start_index..end_index].each do |connected_user|
    actual_response["message"].include?(connected_user).should == true
  end

  steps %{
		Then the JSON at "session_id" should be "session id"
		Then the JSON at "session_type" should be "SESSION"
		Then the JSON should have "access_token"
		}
end