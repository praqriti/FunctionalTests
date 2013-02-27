@javascript
Feature:

  In order to know common connections between users
  As a user
  I want to see a common connections sidebar on the wall of the user

Background:
  When User is on the Sign In page
  And User "camfed_user" logs into Canvas with her credentials

Scenario: Verify User doesnt see common connections box
  Given the following users exists in canvas:
  |USER|
  |camfed_user_1|
  Then User can navigate and view the "public" wall of user "camfed_user_1"
  Then the common connections box "is not" visible
  Then User logs out

@stage
Scenario: User should be able to see the common connections on wall of non connected user
    Given the following users exists in canvas:
    |USER|
    |camfed_user_1|
    |camfed_user_2|
    And "camfed_user" has accepted connection request from "camfed_user_1"
    And "camfed_user_1" has accepted connection request from "camfed_user_2"
    Then User can navigate and view the "public" wall of user "camfed_user_2"
    Then the common connections box "is" visible
    Then User can navigate to the "public" wall of "camfed_user_1" from the common connections sidebar
    Then User logs out
    

@stage    
Scenario: User should be able to see the common connections on wall of a connected user
    Given the following users exists in canvas:
    |USER|
    |camfed_user_1|
    |camfed_user_2|
    Given "camfed_user_1" has his status set to "oolala le lo"
    And "camfed_user" has accepted connection request from "camfed_user_1"
    And "camfed_user" has accepted connection request from "camfed_user_2"
    And "camfed_user_1" has accepted connection request from "camfed_user_2"
    Then User can navigate and view the "public" wall of user "camfed_user_2"
    Then the common connections box "is" visible
    Then User can navigate to the "private" wall of "camfed_user_1" from the common connections sidebar
    Then User logs out
    

Scenario: User should be able to see the common connections on wall with pagination
  Given User "camfed_user" and "camfed_friend" have "6" common connections
  Then User can navigate and view the "public" wall of user "camfed_friend"
  Then the common connections box "is" visible
  Then the sidebar has "6" common connections
  Then User logs out

Scenario: User should be able to see the common connections on wall with ordering
Given User "camfed_user" and "camfed_friend" have the following common connections:
   |COMMON_CONNECTIONS|
   |camfed_friend_1  |
   |camfed_friend_2  |
   |camfed_friend_3  |
   |camfed_friend_4  |
   |camfed_friend_5  |
  Then User can navigate and view the "public" wall of user "camfed_friend"
  Then the common connections box "is" visible
  Then User can view the common connections:
   |COMMON_CONNECTIONS|
   |camfed_friend_1  |
   |camfed_friend_2  |
   |camfed_friend_3  |
   |camfed_friend_4  |
   |camfed_friend_5  |
   Then User logs out
  
  
  

