Feature:

  In order to access my profile 
  As an user
  I want to login to the system using my mobile device

Background:
Given the following user exists in canvas:
|LOGIN_ID|PASSWORD|
|test_ussd_login|password|
  

Scenario: Verify login from USSD
Given I make a new login request
When I enter the login credentials as "test_ussd_login" with password "password"
Then I should see the home page for user "test_ussd_login"

  
Scenario Outline: Verify Incorrect login details
Given I make a new login request
And I enter the login credentials as "<LOGIN_ID>" with password "<PASSWORD>"
Then I should be informed that my username and password is incorrect

Examples:
| LOGIN_ID    | PASSWORD     | 
| test_ussd_login | password_two | 
| test_ussd_login |              |
|                 | password     |
|                 |              |
| test_ussd_login1| password_two |




