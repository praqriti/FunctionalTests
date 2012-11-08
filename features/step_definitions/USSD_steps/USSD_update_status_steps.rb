And /^User chooses the option to "update status"$/ do
  steps %{
      Then User replies with option "2"   
    }
end

Then /^User is given the option to update status or navigate back to home page$/ do
  user_id = CanvasUserInterface.get_user_id
     steps %{
     Then the JSON at "session_id" should be "session id"
     Then the JSON at "session_type" should be "SESSION"
     Then the JSON at "access_token" should be "#{@last_response.parsed_response["access_token"]}"
       }  
     @last_response.parsed_response["response_map"]["0"]["text"].should == "Back"
     
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

When /^User replies "0" from update status page to go back to home page$/ do
  steps %{
      Then User replies with option "0"   
    }
end

Then /^User should see his previously updated message "([^\"]*)"$/ do |message|
  steps %{
      Then the JSON at "message" should be "#{message}\\n\\nEnter your new status"
    }
end

Then /^User should see his previously updated blank message "([^\"]*)"$/ do |message|
  steps %{
      Then the JSON at "message" should be "#{message}Enter your new status"
    }
end

Then /^User should see his previously updated message:$/ do |string|
  steps %{
      Then the JSON at "message" should be "#{string}\\n\\nEnter your new status"
    }
end


Then /^User should get a confirmation that the status was updated successfully$/ do
  message = @messages.get("status_updated")
     steps %{
        Then the JSON at "message" should be "#{message}"
        Then the JSON at "session_id" should be "session id"   
        Then the JSON at "session_type" should be "SESSION"
        Then the JSON at "access_token" should be "#{@last_response.parsed_response["access_token"]}"
      } 
end

And /^User chooses the option to "update status" with incorrect access_token$/ do
  incorrect_access_token = "#{@last_response.parsed_response["access_token"]}" + "A"
  
  body = @last_response.parsed_response
  body.merge!({"message" => "2","access_token" =>"#{incorrect_access_token}"})
  @last_response = JSONSpecInterface.post("#{SEN_URL}",
                                           :body => body.to_json,
                                           :headers => { "Content-Type" => "application/json"})
end
  
Then /^User recieves an error and the session is ended$/ do
  message = @messages.get("something_went_wrong") 
 	steps %{
 	Then the JSON at "session_id" should be "session id"
 	Then the JSON at "session_type" should be "END"
 	Then the JSON at "message" should be "#{message}"
 	}
end


