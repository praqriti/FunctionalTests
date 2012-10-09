Feature:

  In order utilise the social aspect of canvas
  As a user
  I want to update my status using my mobile device
  
  Background:
  Given the following user exists in canvas:
  |USER|
  |rocket|

  Given I make a new USSD login request
  When User "rocket" logs into USSD with her credentials
  Then "rocket" should see the USSD home page
  
  
Scenario: Update and view new status update from USSD
Given User chooses the option to "update status"
When User is given the option to update status or navigate back to home page
And User replies with new status message "new status"
And User should get a confirmation that the status was updated successfully
And User chooses the option to "update status"
Then User should see his previously updated message "new status"

Scenario: Verify blank status update from USSD
Given User chooses the option to "update status"
When User replies with new status message " "
And User should get a confirmation that the status was updated successfully
And User chooses the option to "update status"
Then User should see his previously updated message " "


Scenario: Verify back from update page from USSD
Given User chooses the option to "update status"
When User replies "0" to go back from update status page to home page
Then "rocket" should see the USSD home page


Scenario: Verify no error on status update longer than max allowed length from USSD
Given User chooses the option to "update status"
When User replies with new status message: 
"""
12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
"""
Then User should get a confirmation that the status was updated successfully
And User chooses the option to "update status"
Then User should see his previously updated message:
"""
1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567...
"""

Scenario: Verify user not allowed to continue with incorrect access token

Given User chooses the option to "update status" with incorrect access_token
Then User recieves an error and the session is ended
# And User "camfed_today" is not allowed to "update status" after the session has ended

@wip @manual
Scenario: Verify one user cannot use another users access token
Given the following user exists in canvas:
|LOGIN_ID|PASSWORD|
|user1|password1|
|user2|password2|
Given I make a new login request
When I enter the login credentials as "user1" with password "password1"
And I save the access token for user "user1"
Given I make a new login request
When I enter the login credentials as "user2" with password "password2"
And I save the access token for user "user2"

@wip @manual
Scenario: One user cannot continue with other users access token

@wip
Scenario: Verify that error is given to the user when she enters an invalid option
Given User "camfed_today" sends an invalid option "9" from "home" page
Then User is given an error message















