Feature:

  In order to access my profile 
  As an user
  I want to login to the system using my mobile device
  
Scenario Outline: Verify login from USSD
Given I make a new login request
And I enter the login credentials as "<LOGIN_ID>" with password "<PASSWORD>"
Then I should see the correct authorisation message "<AUTHORISATION MESSAGE>"
And I should see the home page for user "<LOGIN_ID>"

Examples:
| LOGIN_ID          | PASSWORD     | AUTHORISATION MESSAGE       |
| user_one@test.com | password_one | Welcome to SEN!/n/n1. Notifications /n2. Update Status /n3.My Profile /n4.Groups /n5. Course |
# | user_one@test.com | password_two |Incorrect Username/ Password |
# | user_one@test.com |              |Incorrect Username/ Password |
# |                   | password_two |Incorrect Username/ Password |
# |                   |              |Incorrect Username/ Password |
# | user_two@test.com | password_two |Incorrect Username/ Password |


