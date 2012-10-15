@javascript
Feature:

  In order to utilise the social aspect of the application
  As a user
  I want to be able to comment on the status of other users

@wip
Scenario: Verify that a user can comment on the status of other user
  When I am on the Sign In page
  And User "camfed_student_unique" logs into Canvas with her credentials
  And "camfed_student_unique" should see the Canvas home page
  When User "updates" the status message as "status message"
  Then User status "status message" is updated successfully
  And User logs out
  And User "camfed_student_1" logs into Canvas with her credentials
  And User navigates to the wall of "camfed_student_unique"
  Then User comments "Nice status" on the status of "camfed_student_unique"
  Then the comment "Nice status" is visible on the wall
