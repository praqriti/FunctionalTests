Feature:

  In order utilise the social aspect of canvas
  As a user
  I want to update my status using my mobile device
  
Background:
Given I make a new login request
When I enter the login credentials as "test_camfed" with password "password_one"
And I should see the home page for user "test_camfed"
  

Scenario: Update and view new status update from USSD
Given User "test_camfed" chooses the option to "update status"
When User "test_camfed" is given the option to update status or navigate back to home page
And User "test_camfed" replies with new status message "new status"
And User "test_camfed" should get a confirmation that the status was updated successfully
And User "test_camfed" chooses the option to "update status"
Then User "test_camfed" should see his previously updated message "new status"

Scenario: Verify blank status update from USSD
Given User "test_camfed" chooses the option to "update status"
When User "test_camfed" replies with new status message " "
And User "test_camfed" should get a confirmation that the status was updated successfully
And User "test_camfed" chooses the option to "update status"
Then User "test_camfed" should see his previously updated message " "


Scenario: Verify back from update page from USSD
Given User "test_camfed" replies "#" to go back to home page
Then I should see the home page for user "test_camfed"


Scenario: Verify no error on status update longer than max alllowed length from USSD
Given User "test_camfed" chooses the option to "update status"
When User "test_camfed" replies with a new status message: 
"""
12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
"""
Then User "test_camfed" should get a confirmation that the status was updated successfully
And User "test_camfed" chooses the option to "update status"
Then User "test_camfed" should see his previously updated message:
"""
1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567...
"""

Scenario: Verify user not allowed to continue with incorrect access token

Given User "test_camfed" chooses the option to "update status" with incorrect access_token
Then User recieves an error and the session is ended
# And User "test_camfed" is not allowed to "update status" after the session has ended

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
Given User "test_camfed" sends an invalid option "9" from "home" page
Then User is given an error message















