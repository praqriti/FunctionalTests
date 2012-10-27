# @wip
@javascript
Feature:

  In order to utilise the social aspect of the application
  As a user
  I want to be able to comment on the status of other users
  
Background:
Given the following users exists in canvas:
      |USER|
      |camfed_user|
When User is on the Sign In page
And User "camfed_student" logs into Canvas with her credentials
And "camfed_student" should see the Canvas home page
When User "updates" the status message as "status message"
Then User status "status message" is updated successfully
And User logs out

Scenario: Verify that a user can comment on the status of other user 
And User "camfed_user" logs into Canvas with her credentials
And User can navigate and view the wall of user "camfed_student"
Then User comments "Nice status" on the status of "camfed_student"
Then the comment "Nice status" by "camfed_user" is visible on users wall
