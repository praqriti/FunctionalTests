@javascript
Feature:

  As an user
  I am on the home page of canvas
  I get notifications for different actions of my connection

  Background:  
   Given the following users exists in canvas:
      |USER|
      |camfed_friend_1|
      |camfed_friend_2|
    Given User has the following comment notifications:
      |COMMENTED_BY   |COMMENT|
      |camfed_friend_1|camfed friend 1 has something to say|
      |camfed_friend_2|camfed friend 2 has something to say|

@stage
  Scenario: Verify if comment notification is visible to all users
    When User is on the Sign In page
    And User "camfed_user" logs into Canvas with her credentials
    Then home page has the following comment notifications:
        |COMMENTED_BY     |COMMENT|
        |camfed_friend_1  |camfed friend 1 has something to say|
        |camfed_friend_2  |camfed friend 2 has something to say|
    Given User clicks on My Wall
    And User comments "Hello friends" on her status message
    Then User logs out
    When User is on the Sign In page
    And User "camfed_friend_2" logs into Canvas with her credentials
    Then home page has the following comment notifications:
      |COMMENTED_BY   |COMMENT|
      |camfed_user|Hello|
    Then User logs out
    When User is on the Sign In page
    And User "camfed_friend_1" logs into Canvas with her credentials
    Then home page has the following comment notifications:
      |COMMENTED_BY     |COMMENT|
      |camfed_friend_1  |camfed friend 1 has something to say|
      |camfed_friend_2  |camfed friend 2 has something to say|
      |camfed_user      |Hello friends|
    Then User logs out


  Scenario: Verify if comment notification is not visible to the disconnected user  
   When User is on the Sign In page
   And User "camfed_user" logs into Canvas with her credentials
   When User navigates to "My Connections" page
   And User can "disconnect" his connection "camfed_friend_1"
   And User confirms the disconnection "camfed_friend_1"
   Given User clicks on My Wall
   And User comments "Hello friends" on her status message
   Then User logs out
   When User is on the Sign In page
   And User "camfed_friend_1" logs into Canvas with her credentials
   Then home page does not have the following comment notifications:
       |COMMENTED_BY       |COMMENT|
       |camfed_user        |Hello friends|
   Then User logs out
 