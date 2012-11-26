@javascript
Feature:

  In order to prevent misuse
  As a user
  I want to control the user privileges
  
  Background:
  Given the following users exists in canvas:
          |USER|
          |requesting_user|
  Given User "camfed_user" is connected to:
	|USER|
	|requesting_user|
  When User is on the Sign In page
  And User "requesting_user" logs into Canvas with her credentials
  Then "requesting_user" should see the Canvas home page

  Scenario: User must not be able to view the connections of another user
  When User tries to view the connections for user "camfed_user"
  Then User is given page not found error
	
	#need to get status id for the user, to automate this
	@manual
  Scenario: User must not be able view comments
  When User tries to navigate to "requesting_users" comments
  Then User is given authorisation error
  Then User logs out
