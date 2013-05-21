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
    And "camfed_user" has accepted connection request from "Catheryn"
    And "Lizzie" has accepted connection request from "camfed_user"

@stage
  Scenario: Verify if status update notification is sent to connections
    And "camfed_user" has his status set to "status message"
    When User is on the Sign In page
    And User "Catheryn" logs into Canvas with her credentials
    Then Status Updated notification is visible for "camfed_user" with status:"status message"
    Then User logs out
    When User is on the Sign In page
    And User "Marie" logs into Canvas with her credentials
    Then The Status Activity Notification "is not" visible
    Then User logs out

  Scenario: Verify if status update notification is not sent to deleted connection(s)
   When User is on the Sign In page
   And User "camfed_user" logs into Canvas with her credentials
   When User navigates to "My Connections" page
   And User can "disconnect" his connection "Catheryn"
   And User confirms the disconnection "Catheryn"
   And "camfed_user" has his status set to "status message"
   Then User logs out
   When User is on the Sign In page
   And User "Catheryn" logs into Canvas with her credentials
   Then only default status notification is visible
   Then User logs out
