Given /^the following users exists in canvas:$/ do |users_table|
    users_table.hashes.each do |hash|  
      @users << User.create("#{hash["USER"]}")
    end
end

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
	Then the JSON at "session_id" should be "#{@session_id}"
	Then the JSON at "session_type" should be "SESSION"

	}
end

And /^User chooses the "Previous" option$/ do
 steps %{
   Then User replies with option "*"   
 }
end

When /^User replies "0" to go back to home page$/ do
  steps %{
    Then User replies with option "0"  
    Then User should see the message "home_page" 
  }
end

And /^User chooses the "Next" option$/ do
	steps %{
	  Then User replies with option "#"
	}
end

Then /^User should see the message containing "([^\"]*)"$/ do |message|
  expected_message = @messages.get(message)
  @last_response.parsed_response["message"].include?( expected_message).should be_true
end

Then /^User returns with error "([^\"]*)"$/ do |error|
    steps %{
     Then User should see the message containing "#{error}"
    }
end

Given /^User replies with option "(.*?)"$/ do |option|
   body = @last_response.parsed_response
   body.merge!({"message" => "#{option}"})
   @last_response = JSONSpecInterface.post("#{SEN_URL}",
                                           :body => body.to_json,
                                           :headers => { "Content-Type" => "application/json"})
end

Then /^User waits for "(.*?)" seconds$/ do |seconds|
  sleep(seconds.to_i)
end


When /^I save the access token for user "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given /^User "(.*?)" sends an invalid option "(.*?)" from "(.*?)" page$/ do |arg1, arg2, arg3|
  pending # express the regexp above with the code you wish you had
end


