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
	Then User should see his previously updated blank message ""


Scenario: Verify back from update page from USSD
	
	Given User chooses the option to "update status"
	When User replies "0" from update status page to go back to home page
	Then User should see the USSD home page

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
Scenario: Verify that error is given to the user when she enters an invalid option	
	Given User sends an invalid option "9"
	Then User returns to home page with error "invalid_option"

Scenario: Verify user not allowed to continue with incorrect access token
	Given User chooses the option to "update status" with incorrect access_token
	Then User recieves an error and the session is ended

Scenario: status length should be limited to 100 chars if present more in length
    Given There exists a status with more than 100 chars
    And I make a new USSD login request
    When User "camfed_user" logs into USSD with correct credentials
    Then User should see the USSD home page
    And User chooses the option to "update status"
    Then User should see his previously updated message:
    """
    1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567...
    """	

@stage	
Scenario: View status should be reflected on both canvas and ussd app
  Given I make a new USSD login request
  When User "camfed_user" logs into USSD with correct credentials
  Then User should see the USSD home page
  And User chooses the option to "update status"
  And User replies with new status message "new status message" 
  Then User should get a confirmation that the status was updated successfully

	When User is on the Sign In page
  When User "camfed_user" logs into Canvas with her credentials
  Then "camfed_user" should see the Canvas home page
  And status message should be "new status message"

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















