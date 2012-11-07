Given /^User sends an invalid option "([^\"]*)"$/ do |option|
   body = @last_response.parsed_response
   body.merge!({"message" => "#{option}"})
   @last_response = JSONSpecInterface.post("#{SEN_URL}",
                                           :body => body.to_json,
                                           :headers => { "Content-Type" => "application/json"}) 
end

Then /^User should see the message "([^\"]*)"$/ do |message|
  expected_message = @messages.get(message)
	steps %{
	Then the JSON at "message" should be "#{expected_message}"
	Then the JSON at "session_id" should be "session id"   
	Then the JSON at "session_type" should be "SESSION"
	Then the JSON should have "access_token"
	}
end

Then /^User returns to home page with error "([^\"]*)"$/ do |error|
    steps %{
     Then User should see the message "#{error}"
    }
    @last_response.parsed_response["response_map"]["1"]["text"].should == "Notifications"
end

When /^I save the access token for user "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given /^User "(.*?)" sends an invalid option "(.*?)" from "(.*?)" page$/ do |arg1, arg2, arg3|
  pending # express the regexp above with the code you wish you had
end


