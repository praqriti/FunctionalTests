@javascript
Feature:

  In order to know common connections between the 2 users
  As a user
  I want to be know common connections between the 2 users

Background:
  When User is on the Sign In page
  And User "camfed_user" logs into Canvas with her credentials
  Then "camfed_user" should see the Canvas home page

Scenario: Verify User doesnt see common connections box
  Given the following users exists in canvas:
  |USER|
  |camfed_user1|
  When User searches for "camfed_user1" and clicks search
  Then User can navigate and view the wall of user "camfed_user1"
  Then The Common Connections box "is not" visible
  Then User logs out

@stage
Scenario: User should be able to see the common connections on wall of non connected user
    Given the following users exists in canvas:
    |USER|
    |camfed_user1|
    |camfed_user2|
    And "camfed_user" is connected to "camfed_user1"
    And "camfed_user1" is connected to "camfed_user2"
    Then User can navigate and view the wall of user "camfed_user2"
    Then The Common Connections box "is" visible
    Then User can navigate to the "public" wall of "camfed_user1" from the common connections sidebar
    Then User logs out
    

@stage    
Scenario: User should be able to see the common connections on wall of a connected user
    Given the following users exists in canvas:
    |USER|
    |camfed_user1|
    |camfed_user2|
    Given "camfed_user1" has his status set to "oolala le lo"
    And "camfed_user" is connected to "camfed_user1"
    And "camfed_user" is connected to "camfed_user2"
    And "camfed_user1" is connected to "camfed_user2"
    Then User can navigate and view the wall of user "camfed_user2"
    Then The Common Connections box "is" visible
    Then User can navigate to the "private" wall of "camfed_user1" from the common connections sidebar
    Then User logs out
    

Scenario: User should be able to see the common connections on wall with pagination
  Given the following users exists in canvas:
      |USER|
      |Atia|
      |Precious|
      |Marie|
      |Vicky|
      |Catheryn|
      |Jamy|
      |camfed_user2|
  And "camfed_user" is connected to "Atia"
  And "camfed_user" is connected to "Precious"
  And "camfed_user" is connected to "Marie"
  And "camfed_user" is connected to "Vicky"
  And "camfed_user" is connected to "Catheryn"
  And "camfed_user" is connected to "Jamy"
  
  Given "camfed_user2" is connected to "Atia"
  And "camfed_user2" is connected to "Precious"
  And "camfed_user2" is connected to "Marie"
  And "camfed_user2" is connected to "Vicky"
  And "camfed_user2" is connected to "Catheryn"
  And "camfed_user2" is connected to "Jamy"
  
  Then User can navigate and view the wall of user "camfed_user2"
  Then The Common Connections box "is" visible
  Then the sidebar has "6" common connections
  Then User logs out

