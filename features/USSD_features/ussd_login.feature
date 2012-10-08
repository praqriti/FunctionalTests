Feature:

  In order to access my profile 
  As an user
  I want to login to the system using my mobile device

Background:
Given the following user exists in canvas:
|LOGIN_ID|PASSWORD|
|camfed_ussd_test|password_one|
  

Scenario: Verify login from USSD
Given I make a new login request
When I enter the login credentials as "camfed_ussd_test" with password "password_one"
Then I should see the home page for user "camfed_ussd_test"

  
Scenario Outline: Verify Incorrect login details
Given I make a new login request
And I enter the login credentials as "<LOGIN_ID>" with password "<PASSWORD>"
Then I should be informed that my username and password is incorrect

Examples:
| LOGIN_ID    | PASSWORD     | 
| camfed_test | password_two | 
| camfed_test |              |
|             | password_two |
|             |              |
| test_camfed1| password_two |




