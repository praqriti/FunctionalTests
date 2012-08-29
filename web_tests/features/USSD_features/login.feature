Feature:

  In order to access my profile 
  As an user
  I want to login to the system using my mobile device
  
Scenario: login using ussd 
Given I am on "http://localhost:3000/authentication/username"
# When I get the JSON
Then the JSON at "display_text" should include "Enter your password"
