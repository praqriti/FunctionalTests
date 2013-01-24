@javascript
Feature:

  In order to use canvas
  As an user
  I am on the home page of canvas
  I get notifications for different actions of my connection

  Background:
    Given the following users exists in canvas:
      |USER|
      |Marie|
      |Catheryn|
      |Lizzie|
    Given User "Catheryn" is enrolled with following courses:
      |COURSE     |ROLE    |STATUS|
      |History    |Student |active|
    And "camfed_user" is connected to "Catheryn"
    And "Lizzie" is connected to "camfed_user"
    When User is on the Sign In page
    And User "camfed_user" logs into Canvas with her credentials
    Then "camfed_user" should see the Canvas home page

@stage
  Scenario: Verify if status update notification is sent to connections
    When User "updates" the status message as "status message"
    Then User status "status message" is updated successfully
    Then User logs out
    When User is on the Sign In page
    And User "Catheryn" logs into Canvas with her credentials
    Then "Catheryn" should see the Canvas home page
    Then Status Updated notification is visible for "camfed_user" with status:"status message"
    Then User logs out
    When User is on the Sign In page
    And User "Marie" logs into Canvas with her credentials
    Then "Marie" should see the Canvas home page
    Then The Status Activity Notification "is not" visible
    Then User logs out

  Scenario: Verify if status update notification is not sent to deleted connection(s)
   When User navigates to "My Connections" page
   And User can "disconnect" his connection "Catheryn"
   And User confirms the disconnection "Catheryn"
   Then User navigates to canvas home page
   When User "updates" the status message as "status message"
   Then User status "status message" is updated successfully
   Then User logs out
   When User is on the Sign In page
   And User "Catheryn" logs into Canvas with her credentials
   Then "Catheryn" should see the Canvas home page
   Then The Status Activity Notification "is not" visible
   Then User logs out
