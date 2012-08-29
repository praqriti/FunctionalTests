Feature:

  In order to access my profile 
  As an user
  I want to login to the system using my mobile device
  
Background:
  Given I am an existing user of canvas
  
Scenario: login using ussd 
Given I make a login request
And I enter the correct login credentials
Then I successfully login
