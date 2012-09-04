Feature:

  In order to access my profile 
  As an user
  I want to login to the system using my mobile device
  
Background:
 Given the following user exists in canvas:
 | login_id          | password      | 
 | user_one@test.com     | password_one  | 
   
Scenario Outline: Verify login from USSD
Given I make a new login request
And I enter the login credentials as "<login_id>" with password "<password>"
Then I should see the correct authorisation message "<authorisation message>"

Examples:
| login_id | password | authorisation message |
| user_one@test.com | password_two | Incorrect Username/ Password|
| user_one@test.com | password_one | Home                        |
| '!@#?><*()@gmail.com'| password_one |Incorrect Username/ Password |
| user_one@test.com |              |Incorrect Username/ Password |
|                   |              |Incorrect Username/ Password |
| user_two@test.com | password_two |Incorrect Username/ Password |


