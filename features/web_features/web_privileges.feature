@javascript
Feature:

  In order to prevent misuse
  As a user
  I want to control the user privileges
  
  Background:
  Given the following users exists in canvas:
           |USER|
           |requesting_user|
  Given User is on the Sign In page
  Given User "requesting_user" logs into Canvas with her credentials 
  Given User "camfed_user" has accepted connection request from:
 	|USER|
 	|requesting_user|

  @stage
  Scenario: User must not be able to update the status of another user
  Given User tries to update status for "camfed_user" as "camfed student has updated this status" 
  Then User is given page not found error
  Then User navigates to canvas home page
  And User logs out
    
  Scenario: User must not be able to view the connections of another user
  When User tries to view the connections for user "camfed_user"
  Then User is given page not found error
	
	#need to get status id for the user, to automate this
	@manual
  Scenario: User must not be able view comments
  When User tries to navigate to "requesting_users" comments
  Then User is given authorisation error
  Then User logs out
