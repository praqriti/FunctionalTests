Feature:

  In order utilise the social aspect of canvas
  As a user
  I want to update my status using my mobile device
  
Background:
Given the following user exists in canvas:
|LOGIN_ID|PASSWORD|
|camfed_ussd_test|password_one|

Given I make a new login request
When I enter the login credentials as "camfed_ussd_test" with password "password_one"
And I should see the home page for user "camfed_ussd_test"
  

Scenario: Update and view new status update from USSD
Given User "camfed_ussd_test" chooses the option to "update status"
When User "camfed_ussd_test" is given the option to update status or navigate back to home page
And User "camfed_ussd_test" replies with new status message "new status"
And User "camfed_ussd_test" should get a confirmation that the status was updated successfully
And User "camfed_ussd_test" chooses the option to "update status"
Then User "camfed_ussd_test" should see his previously updated message "new status"

Scenario: Verify blank status update from USSD
Given User "camfed_ussd_test" chooses the option to "update status"
When User "camfed_ussd_test" replies with new status message " "
And User "camfed_ussd_test" should get a confirmation that the status was updated successfully
And User "camfed_ussd_test" chooses the option to "update status"
Then User "camfed_ussd_test" should see his previously updated message " "


Scenario: Verify back from update page from USSD
Given User "camfed_ussd_test" chooses the option to "update status"
When User "camfed_ussd_test" is given the option to update status or navigate back to home page
Given User "camfed_ussd_test" replies "0" from update status page to go back to home page
Then I should see the home page for user "camfed_ussd_test"


Scenario: Verify no error on status update longer than max allowed length from USSD
Given User "camfed_ussd_test" chooses the option to "update status"
When User "camfed_ussd_test" replies with new status message: 
"""
12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
"""
Then User "camfed_ussd_test" should get a confirmation that the status was updated successfully
And User "camfed_ussd_test" chooses the option to "update status"
Then User "camfed_ussd_test" should see his previously updated message:
"""
1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567...
"""

Scenario: Verify user not allowed to continue with incorrect access token

Given User "camfed_ussd_test" chooses the option to "update status" with incorrect access_token
Then User recieves an error and the session is ended
# And User "camfed_ussd_test" is not allowed to "update status" after the session has ended

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
Given User "camfed_ussd_test" sends an invalid option "9" from "home" page
Then User is given an error message















