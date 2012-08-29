Given /^I am an existing user of canvas$/ do
  UserInterface.create_user()
end

Given /^I make a login request$/ do
  @last_response = JSONSpecInterface.get("/authentication/new.json",
  :body => { :ussd_request => { :session_id => '1', :service_type => 'new' }}.to_json,
  :headers => { "Content-Type" => "application/json"})
  
  steps %{
     Then the JSON at "display_text" should be "Enter your username"
     Then the JSON at "session_id" should be "1"
   }
    
end

When /^I enter the correct login credentials$/ do
  steps %{
    When I enter the correct username
    And I give the correct password
  }
end

When /^I enter the correct username$/ do
 
  @last_response = JSONSpecInterface.post("/authentication/username.json",
  :body => { :ussd_request => { :message => "#{USER["default"]["login_id"]}" ,:session_id => '1', :service_type => 'session' } }.to_json, 
  :headers => { "Content-Type" => "application/json"})
    
  steps %{
    And the JSON should include {"username":"#{USER["default"]["login_id"]}"}
    Then the JSON at "display_text" should be "Enter your password"
  }  
end   

And /^I give the correct password$/ do
  @last_response = JSONSpecInterface.post("/authentication/login.json",
  :body => { :ussd_request =>
                {:message => "#{USER["default"]["password"]}",
                    :session_id => '1',
                    :service_type => 'session',
                    :return_data => {
                        :username => "#{USER["default"]["login_id"]}"
                                    }
                 } 
              }.to_json, 

  :headers => { "Content-Type" => "application/json"})
    
  # {"service_type"=>"session", "display_text"=>"Home", "return_data"=>{"access_token"=>"qhe5q5osg2omrOaH9MR0lPfpPN4F02ozEkK8PHx53ydVCihfvh00AC8QyB1mgMuv", "user_id"=>30, "account_id"=>1}, "session_id"=>"1"} 
    
end

Then /^I successfully login$/ do
  steps %{
   Then the JSON at "display_text" should be "Home"
   Then the JSON at "session_id" should be "1"
  }
end

