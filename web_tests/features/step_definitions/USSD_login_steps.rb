
# Given /^I make a login request$/ do
#   @last_response = HTTParty.get('http://localhost:3000/authentication/username.json',
#   :query => { :ussd_request => { :message => 'dummy' ,:session_id => '1', :service_type => 'session' } }, 
#   :headers => { "Content-Type" => "application/json"})
#   
#   p @last_response
#        
#    
#    steps %{ 
#       When I get the JSON
#      Then the JSON at "display_text" should include "Enter your password"
#      }
#  
#   
# end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit(page_name)
end