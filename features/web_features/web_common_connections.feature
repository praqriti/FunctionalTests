@javascript
Feature:

  In order to know common connections between the 2 users
  As a user
  I want to be know common connections between the 2 users

Background:
  Given the following users exists in canvas:
   |USER|
   |Delena|
  When User is on the Sign In page
  And User "Delena" logs into Canvas with her credentials
  Then "Delena" should see the Canvas home page
  And User navigates to search page

Scenario: Verify User doesnt see common connections box on wall of not connected user
  Given the following users exists in canvas:
  |USER|
  |Dolores|
  When User searches for "Dolores" and clicks search
  Then User can navigate and view the wall of user "Dolores"
  Then The Common Connections box "is not" visible
  Then User logs out

Scenario: User should be able to see the common connections on wall
  Given the following users exists in canvas:
      |USER|
      |Atia|
      |Precious|
      |Marie|
      |Vicky|
      |Catheryn|
      |Jamy|
      |Lizzie|
  And "Delena" is connected to "Atia"
  And "Delena" is connected to "Precious"
  And "Marie" is connected to "Delena"
  And "Vicky" is connected to "Catheryn"
  And "Vicky" is connected to "Jamy"
  And "Lizzie" is connected to "Vicky"
  And "Delena" is connected to "Vicky"
  Then User can navigate and view the wall of user "Jamy"
  Then The Common Connections box "is" visible
  Then User logs out
