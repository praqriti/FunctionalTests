@javascript
Feature:

  In order to prevent misuse
  As a user
  I want to control the user privileges
  
  Background:
  Given the following users exists in canvas:
  |USER|
  |camfed_user|
  Given User "camfed_student" is connected to:
	|USER|
	|requesting_user|
  When User is on the Sign In page
  And User "camfed_student" logs into Canvas with her credentials
  Then "camfed_student" should see the Canvas home page
  
  Scenario: User must not be able to update the status of another user
  Given User "updates" the status message as "status message"
  When User status "status message" is updated successfully
  When User tries to update status for "camfed_user" as "camfed student has updated this status" 
  When User logs out
  And User "camfed_user" logs into Canvas with her credentials
  And "camfed_user" should see the Canvas home page
  Then User status "camfed student has updated this status" is not updated 
  Then User logs out
    
  Scenario: User must not be able to view the connections of another user
	When User logs out
	And User "camfed_user" logs into Canvas with her credentials
  And "camfed_user" should see the Canvas home page
  When User tries to view "My Connections" for user "camfed_student"
  Then User should be able to see only his connection "requesting_user"
	
  Scenario: User must not be able view the posts of another un-connected user
  When User logs out
  And User "camfed_user" logs into Canvas with her credentials
  And "camfed_user" should see the Canvas home page
  When "camfed_user" tries to view posts for user "camfed_student"
  Then User is given an authorisation error
  
  Scenario: User must not be able to update the comments of another user
  When User logs out
  And User "camfed_user" logs into Canvas with her credentials
  And "camfed_user" should see the Canvas home page
  When "camfed_user" tries to view comments for user "camfed_student"
  Then User is given an authorisation error
