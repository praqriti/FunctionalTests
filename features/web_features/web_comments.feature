@javascript
Feature:

	In order to utilise the social aspect of the application
	As a user
	I want to be able to comment on the status of other users
  
Background:

	Given the following users exists in canvas:
	|USER|
	|camfed_friend_user|
	And "camfed_user" has his status set to "status message"

@stage
Scenario: Verify that a user can comment on the status of other user

	When User is on the Sign In page
	And User "camfed_friend_user" logs into Canvas with her credentials
	And "camfed_friend_user" has accepted connection request from "camfed_user"
	Then User can navigate and view the "private" wall of user "camfed_user"
	Then User comments "Nice status" on the status of "camfed_user"
	Then the comment "Nice status" by "camfed_friend_user" is visible on users wall
	And User logs out

@stage	
Scenario: User must see only the public profile for a non connected user

   Given "camfed_user" has his status set to "camfed user cant see my status" 
   When User is on the Sign In page
   And User "camfed_user" logs into Canvas with her credentials
   Then User can navigate and view the "public" wall of user "camfed_friend_user"
  Then User should see the location as "None"
  And User logs out