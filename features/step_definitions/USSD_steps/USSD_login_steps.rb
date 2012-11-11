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


When /^User "([^\"]*)" logs into USSD with password "([^\"]*)"$/ do |username,password|
  steps %{
    When User enters the username "#{username}"
    And User enters the password "#{password}"
  }
end


When /^User "([^\"]*)" logs into USSD with correct credentials$/ do |username|
	user = @users.find{|user| user.identifier == username}
      steps %{
      When User enters the username "#{user.login_id}"
      And User enters the password "#{user.password}"
    }
end

When /^User enters the username "([^\"]*)"$/ do |login_id|

  expected_message = @messages.get("enter_password")
  steps %{
     Then User replies with option "#{login_id}"   
   }

  steps %{
    And the JSON should include {"username":"#{login_id}"}
    Then the JSON at "message" should be "#{expected_message}"
    Then the JSON at "session_id" should be "session id"
    Then the JSON at "session_type" should be "SESSION"
  }  
end   

And /^User enters the password "([^\"]*)"$/ do |password|
  steps %{
     Then User replies with option "#{password}"   
   }
end


Then /^I should be informed that my username and password is incorrect$/ do 
  expected_message = @messages.get("incorrect_credentials")
  steps %{
    Then the JSON at "message" should be "#{expected_message}"
    Then the JSON at "session_id" should be "session id"   
    Then the JSON at "session_type" should be "SESSION"
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

