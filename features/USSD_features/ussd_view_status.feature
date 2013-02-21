@javascript
Feature:

	In order to know about the social surroundings
	As a User
	I want to be able to view my connected connections on my mobile device

Background:
    Given the following users exists in canvas:
      |USER|
      |connected_user1|
      |connected_user2|
      |connected_user3|
      |connected_user4|
      |connected_user5|
    And User "camfed_user" has accepted connection request from:
      |USER|
      |connected_user1|
      |connected_user2|
      |connected_user3|
      |connected_user4|
      |connected_user5|


Scenario: View status of a connected user
        Given "connected_user5" has his status set to "oolala le lo"
        And I make a new USSD login request
        When User "camfed_user" logs into USSD with correct credentials
        Then User should see the USSD home page
        Given User chooses the option "Connections"
        Then User should see the connections menu
        When User chooses option "1"
        Then User should see ordered connections list on page "1"
        When User chooses option "1"
        Then User should see the current status of "connected_user5"
        When User chooses the "Previous" option
        Then User should see ordered connections list on page "1"
        When User chooses option "2"
        Then User should see the empty status of "connected_user4"

Scenario: View status of a connected user is truncated on display
        Given "connected_user4" has a status with more than 100 characters
        And I make a new USSD login request
        When User "camfed_user" logs into USSD with correct credentials
        Then User should see the USSD home page
        Given User chooses the option "Connections"
        Then User should see the connections menu
        When User chooses option "1"
        Then User should see ordered connections list on page "1"
        When User chooses option "2"
        Then User should see the current status of "connected_user4" truncated with char limit

Scenario: View "View comments" option on connection's status with count of comments
  Given "connected_user5" has his status set to "oolala le lo"
  Then "connected_user5" comments "First comment" on the status
  And I make a new USSD login request
  When User "camfed_user" logs into USSD with correct credentials
  Then User should see the USSD home page
  Given User chooses the option "Connections"
  Then User should see the connections menu
  When User chooses option "1"
  Then User should see the list of connected users for page "1"
  When User chooses option "1"
  Then User should see the current status of "connected_user5"
  Then User should see "View Comments[1]"
