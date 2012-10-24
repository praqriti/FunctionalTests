Given /^User chooses the option "Notifications"$/ do
  body = @last_response.parsed_response
   body.merge!({"message" => "1"})
   @last_response = JSONSpecInterface.post("#{SEN_URL}",
                                           :body => body.to_json,
                                           :headers => { "Content-Type" => "application/json"})
end

Then /^User should see the notifications menu$/ do
  user_id = CanvasUserInterface.get_user_id
  steps %{
    Then the JSON at "session_id" should be "session id"
    Then the JSON at "session_type" should be "SESSION"
    Then the JSON should have "access_token"
  }

end

When /^User replies "0" from notifications page to go back to home page$/ do
  user_id = CanvasUserInterface.get_user_id
  
  @last_response = JSONSpecInterface.post("#{SEN_URL}",
      :body => {
          :session_id => "session id",
          :session_type => "SESSION",
          :message => "0",
          :access_token =>"#{@last_response.parsed_response["access_token"]}",
          :response_map =>
              { "2"=>
                    {"text"=>"Social Notifications", "url"=>"sen/users/#{user_id}/notifications"},
                "1"=>
                    {"text"=>"Learning Notifications", "url"=>"sen/users/#{user_id}/notifications"},
                "0"=>
                    {"text"=>"Back","url"=>"sen/users/#{user_id}"}
              }
      }.to_json,
      :headers => { "Content-Type" => "application/json"})

end



