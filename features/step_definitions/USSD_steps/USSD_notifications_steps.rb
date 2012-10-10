Given /^User chooses the option "Notifications"$/ do
  user = CanvasUserInterface.get_user
  user_id = CanvasUserInterface.find_user(user.login_id)["id"]
  @last_response = JSONSpecInterface.post("#{SEN_URL}",
      :body => {
          :session_id => "session id",
          :session_type => "SESSION",
          :message => "1",
          :access_token =>"#{@last_response.parsed_response["access_token"]}",
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

Then /^User should see the notifications menu$/ do
  user = CanvasUserInterface.get_user
  user_id = CanvasUserInterface.find_user(user.login_id)["id"]
  steps %{
    Then the JSON at "session_id" should be "session id"
    Then the JSON at "session_type" should be "SESSION"
    Then the JSON should have "access_token"
    Then the JSON at "response_map" should be:
    """
    {
              "2": {
                "text": "Social Notifications",
                "url": "sen/users/#{user_id}/notifications/social"
              },
              "1": {
                "text": "Learning Notifications",
                "url": "sen/users/#{user_id}/notifications/learning"
              },
              "0": {
                "text": "Home",
                "url": "sen/users/#{user_id}"
              }
    }
    """
  }

end

When /^User replies "0" from notifications page to go back to home page$/ do
  user = CanvasUserInterface.get_user
  user_id = CanvasUserInterface.find_user(user.login_id)["id"]
  
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



