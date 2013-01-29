@javascript
Feature:

  As an user
  I am on the home page of canvas
  I get notifications for different actions of my connection

  Background:
    Given the following users exists in canvas:
      |USER|
      |Catheryn|
      |Lizzie|
    Given User "camfed_user" is enrolled with following courses:
      |COURSE     |ROLE    |STATUS|
      |History    |Student |active|
    Given User "Lizzie" is enrolled with following courses:
      |COURSE     |ROLE    |STATUS|
      |History    |Student |active|
    And "camfed_user" has his status set to "status message"
    And "camfed_user" is connected to "Catheryn"
    And "Lizzie" is connected to "camfed_user"
    When User is on the Sign In page
    And User "Lizzie" logs into Canvas with her credentials

@stage
  Scenario: Verify if comment notification is visible to the user with status
    Then User can navigate and view the "private" wall of user "camfed_user"
    Then User comments "Lizzie's Comment" on the status of "camfed_user"
    Then the comment "Lizzie's Comment" by "Lizzie" is visible on users wall
    Then User logs out
    When User is on the Sign In page
    And User "camfed_user" logs into Canvas with her credentials
    Then Comment added notification is visible for "Lizzie" with comment:"Lizzie's Comment"
    Then User logs out
    When User is on the Sign In page
    And User "Catheryn" logs into Canvas with her credentials
    Then User can navigate and view the "private" wall of user "camfed_user"
    Then User comments "Catheryn's Comment" on the status of "camfed_user"
    Then User logs out
    When User is on the Sign In page
    And User "Lizzie" logs into Canvas with her credentials
    Then Comment added notification is visible for "Catheryn" with comment:"Catheryn's Comment"
    Then User logs out

@wip
  Scenario: Verify if comment notification is not visible to the disconnected user
   Then User can navigate and view the "private" wall of user "camfed_user"
   Then User comments "Lizzie's Comment" on the status of "camfed_user"
   Then the comment "Lizzie's Comment" by "Lizzie" is visible on users wall
   Then User logs out
   And User "camfed_user" logs into Canvas with her credentials
   When User navigates to "My Connections" page
   And User can "disconnect" his connection "Lizzie"
   And User confirms the disconnection "Lizzie"
   Then User logs out

   When User is on the Sign In page
   And User "Catheryn" logs into Canvas with her credentials
   Then User can navigate and view the "private" wall of user "camfed_user"
   Then User comments "Catheryn's Comment" on the status of "camfed_user"
   Then User logs out
   When User is on the Sign In page
   And User "Lizzie" logs into Canvas with her credentials
   Then The Status Activity Notification "is not" visible
   Then User logs out
