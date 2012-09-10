Feature:

  In order to access my profile 
  As an user
  I want to login to the system using my mobile device
  

Scenario: Verify login from USSD
Given I make a new login request
When I enter the login credentials as "user_one@test.com" with password "password_one"
Then I should be able to see the home page

  
Scenario Outline: Verify Incorrect login details
Given I make a new login request
And I enter the login credentials as "<LOGIN_ID>" with password "<PASSWORD>"
Then I should be informed that my username and password is incorrect

Examples:
| LOGIN_ID          | PASSWORD     | 
| user_one@test.com | password_two | 
| user_one@test.com |              |
|                   | password_two |
|                   |              |
| user_two@test.com | password_two |



