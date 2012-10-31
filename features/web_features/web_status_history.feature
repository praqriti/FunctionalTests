@javascript
Feature:

  In order to know my past statuses
  As a User
  I want to be able to view my status history

Background:

  When User is on the Sign In page
  And User "camfed_student" logs into Canvas with her credentials
  Then "camfed_student" should see the Canvas home page


Scenario: Verify previous status link is visible on my wall page

  And "camfed_student" has his status set to "status message 1"
  And "camfed_student" has his status set to "status message 2"
  And "camfed_student" has his status set to "status message 3"
  Then User clicks on My Wall
  And User lands on My Wall and can view all the elements
  Then User should see the previous statuses link
  Then User logs out


Scenario: Verify user can view previous 5 status messages

  And "camfed_student" has his status set to "status message 1"
  And "camfed_student" has his status set to "status message 2"
  And "camfed_student" has his status set to "status message 3"
  And "camfed_student" has his status set to "status message 4"
  And "camfed_student" has his status set to "status message 5"
  And "camfed_student" has his status set to "status message 6"
  Then User clicks on My Wall
  And User lands on My Wall and can view all the elements
  Then User clicks on Show previous status messages link
  Then User should see previous 5 status messages
  |STATUS|
  |status message 5|
  |status message 4|
  |status message 3|
  |status message 2|
  |status message 1|
  Then User logs out
