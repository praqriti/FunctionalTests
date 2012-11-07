@javascript
Feature:

	In order to utilise the social aspect of the application
	As a user
	I want to be able to comment on the status of other users
  
Background:

	Given the following users exists in canvas:
	|USER|
	|camfed_user|
	And "camfed_student" has his status set to "status message"

Scenario: Verify that a user can comment on the status of other user

	When User is on the Sign In page
	And User "camfed_user" logs into Canvas with her credentials
	Then "camfed_user" should see the Canvas home page
	And "camfed_student" is connected to "camfed_student"
	And User can navigate and view the wall of user "camfed_student"
	Then User comments "Nice status" on the status of "camfed_student"
	Then the comment "Nice status" by "camfed_user" is visible on users wall
