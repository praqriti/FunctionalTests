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

  Scenario: Verify if status update notification is sent to connections
    When User "updates" the status message as "status message"
    Then User status "status message" is updated successfully
    Then User logs out
    When User is on the Sign In page
    And User "Catheryn" logs into Canvas with her credentials
    Then "Catheryn" should see the Canvas home page
    Then The Status Updated Notification "is" visible
    Then Status Updated notification is visible for "camfed_user" with status:"status message"
    Then User logs out
    When User is on the Sign In page
    And User "Marie" logs into Canvas with her credentials
    Then "Marie" should see the Canvas home page
    Then The Status Updated Notification "is not" visible
    Then User logs out