@javascript

Feature:

  In order to know common connections between the 2 users
  As a user
  I want to be know common connections between the 2 users

Background:
  When User is on the Sign In page
  And User "camfed_user" logs into Canvas with her credentials
  Then "camfed_user" should see the Canvas home page
  And User navigates to search page

Scenario: Verify User doesn't see common connections box on wall of not connected user
  Given the following users exists in canvas:
  |USER|
  |non_friend|
  When User searches for "non_friend" and clicks search
  Then User can navigate and view the wall of user "non_friend"
  Then The Common Connections box "is not" visible
  Then User logs out

Scenario: User should be able to see the common connections on wall
  Given the following users exists in canvas:
    |USER|
    |user|
    |user1|
    |user2|
    |user3|
    |user4|
    |user5|
  And "camfed_user" is connected to "user"
  And "camfed_user" is connected to "user2"
  And "user3" is connected to "camfed_user"
  And "camfed_user" is connected to "user5"
  And "user2" is connected to "user"
  And "user" is connected to "user3"
  And "user" is connected to "user4"
  When User searches for "user" and clicks search
  Then User can navigate and view the wall of user "user"
  Then The Common Connections box "is" visible
  Then User logs out
