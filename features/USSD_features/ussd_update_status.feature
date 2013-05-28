@javascript
Feature:

	In order utilise the social aspect of canvas
	As a user
	I want to update my status using my mobile device
  
Background:
  
	Given I make a new USSD login request
	When User "camfed_user" logs into USSD with correct credentials
	Then User should see the USSD home page

@stage
Scenario: Update and view new status update from USSD

    Given User chooses the option to view "my status"
	And User chooses the option to "update status"
	Then User is given the option to update status or navigate back to home page
	When User replies with new status message "new status"
    And User waits for "10" seconds
	Then User should get a confirmation that the status was updated successfully
	And User should see his previously updated message "new status"

Scenario: Verify blank status update from USSD

	Given User chooses the option to view "my status"
	And User chooses the option to "update status"
	When User replies with new status message " "
	Then User should get a confirmation that the status was updated successfully
	And User should see his previously updated message ""


Scenario: Verify back from update page from USSD
	
	Given User chooses the option to view "my status"
	And User chooses the option to "update status"
	When User replies with "0"
	Then User should see the USSD my status page

	Given User chooses the option to "update status"
	When User replies with new status message: 
	"""
	12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	"""
    And User waits for "10" seconds
	Then User should get a confirmation that the status was updated successfully
	And User should see his previously updated message:
	"""
	12345678901234567890123456789012345678901234567890123456789012345678901234567...
	"""
Scenario: Verify that error is given to the user when she enters an invalid option	
	Given User sends an invalid option "9"
	Then User returns with error "invalid_option"

@stage @integration	
Scenario: View status should be reflected on both canvas and ussd app
  Given I make a new USSD login request
  When User "camfed_user" logs into USSD with correct credentials
  Then User should see the USSD home page
  When User chooses the option to view "my status"
  And User chooses the option to "update status"
  When User replies with new status message "new status message"
  Then User should get a confirmation that the status was updated successfully

  When User is on the Sign In page
  When User "camfed_user" logs into Canvas with her credentials
  And status message should be "new status message"
  Then User logs out

@wip @manual
Scenario: Verify one user cannot use another users access token

	Given the following user exists in canvas:
	|LOGIN_ID|PASSWORD|
	|user1|password1|
	|user2|password2|
	Given I make a new USSD login request
	When I enter the login credentials as "user1" with password "password1"
	And I save the access token for user "user1"
	Given I make a new USSD login request
	When I enter the login credentials as "user2" with password "password2"
	And I save the access token for user "user2"

  @manual
  Scenario: Verify no error on status update longer than max allowed length from USSD
  
  @manual
  Scenario: Verify a status greater than 100 characters entered from web is truncated on USSD















