And /^User chooses the option to "update status"$/ do
  body = @last_response.parsed_response
   body.merge!({"message" => "2"})
   @last_response = JSONSpecInterface.post("#{SEN_URL}",
                                           :body => body.to_json,
                                           :headers => { "Content-Type" => "application/json"})    
end

Then /^User is given the option to update status or navigate back to home page$/ do
  user_id = CanvasUserInterface.get_user_id
     steps %{
     Then the JSON at "session_id" should be "session id"
     Then the JSON at "session_type" should be "SESSION"
     Then the JSON at "access_token" should be "#{@last_response.parsed_response["access_token"]}"

     Then the JSON at "response_map" should be: 
       """
            {
              "target_url":"sen/users/#{user_id}/status/create",
              "0":
              {"text":"Back","url":"sen/users/#{user_id}"}
           }

       """  
       }  

end 

When /^User replies with new status message "([^\"]*)"$/ do |message|
  body = @last_response.parsed_response
   body.merge!({"message" => "#{message}"})
   @last_response = JSONSpecInterface.post("#{SEN_URL}",
                                           :body => body.to_json,
                                           :headers => { "Content-Type" => "application/json"})
end

When /^User replies with new status message:$/ do |string|
  user_id = CanvasUserInterface.get_user_id
  
  @last_response = JSONSpecInterface.post("#{SEN_URL}",
    :body => {
        :session_id => "session id",
        :session_type => "SESSION",
        :message => "#{string}",
        :access_token =>"#{@last_response.parsed_response["access_token"]}",
        :response_map => 
         { "$"=>
            {"url"=>"sen/users/#{user_id}/status/create"},
           "0"=>
            {"text"=>"Back","url"=>"sen/users/#{user_id}"}
         }
        }.to_json,
    :headers => { "Content-Type" => "application/json"})
  
end

When /^User replies "0" from update status page to go back to home page$/ do
  body = @last_response.parsed_response
  body.merge!({"message" => "0"})
   @last_response = JSONSpecInterface.post("#{SEN_URL}",
                                           :body => body.to_json,
                                           :headers => { "Content-Type" => "application/json"})
end

Then /^User should see his previously updated message "([^\"]*)"$/ do |message|
  steps %{
      Then the JSON at "message" should be "#{message}\\n\\nEnter your new status"
    }
end

Then /^User should see his previously updated message:$/ do |string|
  steps %{
      Then the JSON at "message" should be "#{string}\\n\\nEnter your new status"
    }
end


Then /^User should get a confirmation that the status was updated successfully$/ do
  user_id = CanvasUserInterface.get_user_id
     steps %{
        Then the JSON at "message" should be "Status Updated\\n"
        Then the JSON at "session_id" should be "session id"   
        Then the JSON at "session_type" should be "SESSION"
        Then the JSON at "access_token" should be "#{@last_response.parsed_response["access_token"]}"
      } 
end

And /^User chooses the option to "update status" with incorrect access_token$/ do
  user_id = CanvasUserInterface.get_user_id
  access_token = "#{@last_response.parsed_response["access_token"]}" + "A"

   @last_response = JSONSpecInterface.post("#{SEN_URL}",
    :body => {
        :session_id => "session id",
        :session_type => "SESSION",
        :message => "2",
        :access_token => access_token,
        :response_map => 
         {
                "5"=> {
                   "text"=> "Courses",
                    "url"=> "sen/users/#{user_id}/courses"
                  },
                  "4"=> {
                    "text"=> "Groups",
                    "url"=> "sen/users/#{user_id}/groups"
                  },
                  "3"=> {
                    "text"=> "My Profile",
                    "url"=> "sen/users/#{user_id}/profile"
                  },
                  "2"=> {
                    "text"=> "Update Status",
                    "url"=> "sen/users/#{user_id}/status"
                  },
                  "1"=> {
                    "text"=> "Notifications",
                    "url"=> "sen/users/#{user_id}/notifications"
                  }
            }     
        }.to_json,
    :headers => { "Content-Type" => "application/json"})
    
end 

Then /^User recieves an error and the session is ended$/ do
	steps %{
	Then the JSON at "session_id" should be "session id"
	Then the JSON at "session_type" should be "END"
	Then the JSON at "message" should be "Something went wrong. Please try again"
	}    
end

Given /^User sends an invalid option "([^\"]*)"$/ do |option|
   body = @last_response.parsed_response
   body.merge!({"message" => "#{option}"})
   @last_response = JSONSpecInterface.post("#{SEN_URL}",
                                           :body => body.to_json,
                                           :headers => { "Content-Type" => "application/json"}) 
end

