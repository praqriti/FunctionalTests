# USER = YAML.load(File.read("features/support/user_data.yml"))

Given /^the following user exists in canvas:$/ do |users_table|
  users_table.hashes.each do |hash|  
     CanvasUserInterface.create_user("#{hash["login_id"]}","#{hash["password"]}")
  end
end

Then /^the following users are removed from canvas:$/ do |users_table|
   users_table.hashes.each do |hash|
     CanvasUserInterface.delete_user("#{hash["login_id"]}")
  end
end

Given /^I make a new login request$/ do
  @last_response = JSONSpecInterface.post("#{SEN_URL}",
  :body => {
      :session_id => "session id",
      :session_type => "NEW",
      :message => "1",
      }.to_json,
  :headers => { "Content-Type" => "application/json"})
   steps %{
   Then the JSON at "message" should be "Enter your username"
   Then the JSON at "session_id" should be "session id"
   Then the JSON at "session_type" should be "SESSION"
 }
 # Then the JSON should include {"url"=>"sen/users"}
 
end

When /^I enter the login credentials as "([^\"]*)" with password "([^\"]*)"$/ do |login_id,password|
  steps %{
    When I enter the username "#{login_id}"
    And I enter the password "#{password}" for user "#{login_id}"
  }
end

When /^I enter the username "([^\"]*)"$/ do |login_id|
 
  @last_response = JSONSpecInterface.post("#{SEN_URL}",
  :body => {
       :session_id => "session id",
       :session_type => "SESSION",
       :message => "#{login_id}",
       :response_map => {"$"=>{"url"=>"sen/users"}},
       }.to_json,
   :headers => { "Content-Type" => "application/json"})
    
  steps %{
    And the JSON should include {"username":"#{login_id}"}
    Then the JSON at "message" should be "Enter your password"
    Then the JSON at "session_id" should be "session id"
    Then the JSON at "session_type" should be "SESSION"
  }  
  # Then the JSON should include {"$":"/sen/users/password"}
end   

And /^I enter the password "([^\"]*)" for user "([^\"]*)"$/ do |password,login_id|
  @last_response = JSONSpecInterface.post("#{SEN_URL}",
  :body => {                                
         :session_id => "session id",
         :session_type => "SESSION",
         :params => {"username" => "#{login_id}"},
         :message => "#{password}",
         :response_map => {"$"=>{"url"=>"sen/users/password"}},
              }.to_json, 

  :headers => { "Content-Type" => "application/json"})
    
            
end

Then /^I should be informed that my username and password is incorrect$/ do 
auth_message = "Incorrect Username/ Password"
  steps %{
    Then the JSON at "message" should be "#{auth_message}"
    Then the JSON at "session_id" should be "session id"   
    Then the JSON at "session_type" should be "END"
    Then the JSON should not have "access_token"
    Then the JSON should not have "response_map"
  }
end


Then /^I should see the home page for user "([^\"]*)"$/ do |login_id|
  user_id = CanvasUserInterface.find_user(login_id)["id"]
   auth_message = "Welcome to SEN!\\n"
   steps %{
      Then the JSON at "message" should be "#{auth_message}"
      Then the JSON at "session_id" should be "session id"   
      Then the JSON at "session_type" should be "SESSION"
      Then the JSON should have "access_token"
      Then the JSON at "response_map" should be: 
      """
      {
            "5": {
               "text": "Courses",
                "url": "sen/users/#{user_id}/courses"
              },
              "4": {
                "text": "Groups",
                "url": "sen/users/#{user_id}/groups"
              },
              "3": {
                "text": "My Profile",
                "url": "sen/users/#{user_id}/profile"
              },
              "2": {
                "text": "Update Status",
                "url": "sen/users/#{user_id}/status"
              },
              "1": {
                "text": "Notifications",
                "url": "sen/users/#{user_id}/notifications"
              }
        }
      
      """
    }
end

