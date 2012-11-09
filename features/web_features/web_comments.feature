@wip
@javascript
Feature:

	In order to utilise the social aspect of the application
	As a user
	I want to be able to comment on the status of other users
  
Background:

	Given the following users exists in canvas:
	|USER|
	|test_user|
	And "camfed_user" has his status set to "status message"

Scenario: Verify that a user can comment on the status of other user

	When User is on the Sign In page
	And User "test_user" logs into Canvas with her credentials
	Then "camfed_user" should see the Canvas home page
	And "camfed_user" is connected to "camfed_user"
	And User can navigate and view the wall of user "camfed_user"
	Then User comments "Nice status" on the status of "camfed_user"
	Then the comment "Nice status" by "test_user" is visible on users wall
