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
       :response_map => {"$"=>"sen/users"},
       }.to_json,
   :headers => { "Content-Type" => "application/json"})
    
  steps %{
    And the JSON should include {"username":"#{login_id}"}
    Then the JSON at "message" should be "Enter your password"
    Then the JSON at "session_id" should be "session id"
    Then the JSON at "session_type" should be "SESSION"
  }  
  
end   

And /^I enter the password "([^\"]*)" for user "([^\"]*)"$/ do |password,login_id|
  @last_response = JSONSpecInterface.post("#{SEN_URL}",
  :body => {                                
         :session_id => "session id",
         :session_type => "SESSION",
         :params => {"username" => "#{login_id}"},
         :message => "#{password}",
         :response_map => {"$"=>"sen/users/password"},
              }.to_json, 

  :headers => { "Content-Type" => "application/json"})
        
end

Then /^I should see the correct authorisation message "([^\"]*)"$/ do |auth_message|
  steps %{
   
   Then the JSON at "message" should be "#{auth_message}"
   Then the JSON at "session_id" should be "session id"   
  }
  
  if auth_message != "Home"
    steps %{Then the JSON at "session_type" should be "END"
            Then the JSON should not have "access_token"}
  else
    steps %{Then the JSON at "session_type" should be "SESSION"
            Then the JSON should have "access_token"}
  end 
  
end

Then /^I should be able to see the home page options correctly$/ do
  user_id = UserInterface.get_user
  steps %{
    Then the JSON at "response_map" should be:
    """
    {
     "5"=>{"url"=>"sen/users/#{user_id}/courses", "text"=>"Courses"},
     "4"=>{"url"=>"sen/users/#{user_id}/groups", "text"=>"Groups"},
     "3"=>{"url"=>"sen/users/#{user_id}/profile", "text"=>"My Profile"},
     "2"=>{"url"=>"sen/users/#{user_id}/status", "text"=>"Update Status"},
     "1"=>{"url"=>"sen/users/#{user_id}/notifications", "text"=>"Notifications"}
    }.to_json
    """
  }
end

