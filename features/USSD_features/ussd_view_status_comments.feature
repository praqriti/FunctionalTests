@javascript
Feature:

	In order to know about the social surroundings
	As a User
	I want to be able to comment on status of my connection

Background:
    Given the following users exists in canvas:
      |USER|
      |connected_user1|
    And User "camfed_user" is connected to:
      |USER|
      |connected_user1|

Scenario: View "View comments" option on connection's status with count of comments
  Given "connected_user1" has his status set to "oolala le lo"
  Then "connected_user1" comments "First comment" on the status
  Then "connected_user1" comments "Second comment" on the status
  Then "camfed_user" comments "Third comment" on the status
  And I make a new USSD login request
  When User "camfed_user" logs into USSD with correct credentials
  Then User should see the USSD home page
  Given User chooses the option "Connections"
  Then User should see the connections menu
  When User chooses option "1"
  Then User should see the list of connected users for page "1"
  When User chooses option "1"
  Then User should see the current status of "connected_user1"
  Then User should see "View Comments[3]"
  When User chooses option "2"
  Then User should see "Third comment"
  Then User should not see "Previous"
  Then User should see "Next"
  When User chooses the "Next" option
  Then User should see "Second comment"
  Then User should see the "Next" and "Previous" option
  When User chooses the "Next" option
  Then User should see "First comment"
  Then User should not see "Next"
  Then User should see "Previous"