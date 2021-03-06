And /^"(.*?)" has his status set to "(.*?)"$/ do |user_identifier, status|
  user = @users.find{|user1| user1.identifier == user_identifier}
  @status = StatusInterface.create(:message => status, :user => user)
  @statuses << @status
end

And /^User chooses the option to view "my status"$/ do
  steps %{
      Then User replies with option "2"
    }
end

And /^User chooses the option to "update status"$/ do
  steps %{
      Then User replies with option "1"
    }
end

Then /^User is given the option to update status or navigate back to home page$/ do
     steps %{
     Then the JSON at "session_id" should be "#{@session_id}"
     Then the JSON at "session_type" should be "SESSION"
       }
end

When /^User replies with new status message "([^\"]*)"$/ do |message|
  steps %{
      Then User replies with option "#{message}"   
    }
end

When /^User replies with new status message:$/ do |string|
  steps %{
      Then User replies with option "#{string}"   
    }
end

Then /^User should see his previously updated message "([^\"]*)"$/ do |message|
  steps %{
    Then User should see "#{message}"
  }
end

Then /^User should see his previously updated message:$/ do |string|
  steps %{
    Then User should see "#{string}"
  }
end


Then /^User should get a confirmation that the status was updated successfully$/ do
  message = @messages.get("status_updated")
  actual_response = @last_response.parsed_response

  actual_response["message"].include?( message).should be_true

  steps %{
    Then the JSON at "session_id" should be "#{@session_id}"
    Then the JSON at "session_type" should be "SESSION"
  }
  actual_response
     
end

And /^User chooses the option to "update status" with incorrect access_token$/ do
  incorrect_access_token = "A" + "#{@last_response.parsed_response["access_token"]}"
  body = @last_response.parsed_response
  body.merge!({"message" => "2","access_token" =>"#{incorrect_access_token}"})
  @last_response = JSONSpecInterface.post("#{SEN_URL}",
                                           :body => body.to_json,
                                           :headers => { "Content-Type" => "application/json"})
                                           
end
  
Then /^User recieves an error and the session is ended$/ do
  message = @messages.get("something_went_wrong")
 	steps %{
 	Then the JSON at "session_id" should be "#{@session_id}"
 	Then the JSON at "session_type" should be "END"
 	Then the JSON at "message" should be "#{message}"
 	}

end

Given /^There exists a status with more than 100 chars$/ do
    @status = StatusInterface.create(
    :message => "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890",
    :user => @logged_in_user)
    @statuses << @status
end

Given /^"([^\"]*)" has a status with more than 100 characters$/ do |username|
  user = @users.find{|user1| user1.identifier == username}
    @status = StatusInterface.create(
    :message => "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890",
    :user => user)
    @statuses << @status
end

When /^User replies with "([^\"]*)"$/ do |message|
  steps %{
      Then User replies with option "#{message}"
    }
end





