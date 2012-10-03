When /^User "([^\"]*)" enters invalid option "([^\"]*)"$/ do |login_id,message|
user_id = CanvasUserInterface.find_user(login_id)["id"]
   
 @last_response = JSONSpecInterface.post("#{SEN_URL}",
  :body => {
      :session_id => "session id",
      :session_type => "SESSION",
      :message => "#{message}",
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

Then /^User is given an error message$/ do
    steps %{
      Then the JSON at "message" should be "Invalid Option"
    }
end

When /^I save the access token for user "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given /^User "(.*?)" sends an invalid option "(.*?)" from "(.*?)" page$/ do |arg1, arg2, arg3|
  pending # express the regexp above with the code you wish you had
end

