Given /^I make a new USSD login request$/ do
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


When /^User "([^\"]*)" logs in with "([^\"]*)"$/ do |user,password|
  user = CanvasUserInterface.get_user 
  steps %{
    When User enters the username "#{user.login_id}"
    And User enters the password "#{password}" for user "#{user.login_id}"
  }
end


When /^User "([^\"]*)" logs into USSD with her credentials$/ do |user|
user = CanvasUserInterface.get_user 
      steps %{
      When User enters the username "#{user.login_id}"
      And User enters the password "#{user.password}" for user "#{user.login_id}"
    }
end

When /^User enters the username "([^\"]*)"$/ do |login_id|
 
  @last_response = JSONSpecInterface.post("#{SEN_URL}",
  :body => {
       :session_id => "session id",
       :session_type => "SESSION",
       :message => "#{login_id}",
       :response_map => {"target_url"=>"sen/users"},
       }.to_json,
   :headers => { "Content-Type" => "application/json"})
    
  steps %{
    And the JSON should include {"username":"#{login_id}"}
    Then the JSON at "message" should be "Enter your password"
    Then the JSON at "session_id" should be "session id"
    Then the JSON at "session_type" should be "SESSION"
  }  
end   

And /^User enters the password "([^\"]*)" for user "([^\"]*)"$/ do |password,login_id|
  @last_response = JSONSpecInterface.post("#{SEN_URL}",
  :body => {                                
         :session_id => "session id",
         :session_type => "SESSION",
         :params => {"username" => "#{login_id}"},
         :message => "#{password}",
         :response_map => {"target_url"=>"sen/users/password"},
              }.to_json, 

  :headers => { "Content-Type" => "application/json"})
         
end

Then /^I should be informed that my username and password is incorrect$/ do 
  expected_message = @messages.get("incorrect_credentials")
  steps %{
    Then the JSON at "message" should be "#{expected_message}"
    Then the JSON at "session_id" should be "session id"   
    Then the JSON at "session_type" should be "END"
    Then the JSON should not have "access_token"
    Then the JSON should not have "response_map"
  }
end


Then /^User should see the USSD home page$/ do
   expected_message = @messages.get("home_page")
   steps %{
      Then the JSON at "message" should be "#{expected_message}"
      Then the JSON at "session_id" should be "session id"   
      Then the JSON at "session_type" should be "SESSION"
      Then the JSON should have "access_token"
    }
    
   
end

