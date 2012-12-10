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
    And User "camfed_user" is connected to:
      |USER|
      |connected_user1|
      |connected_user2|
      |connected_user3|
      |connected_user4|
      |connected_user5|
    And I make a new USSD login request
	When User "camfed_user" logs into USSD with correct credentials
	Then User should see the USSD home page
    Given User chooses the option "Connections"
    Then User should see the connections menu

Scenario: View connected connections
    When User chooses option "1"
    Then User should see the list of connected users for page "1"
    When User chooses the "Next" option
    Then User should see the list of connected users for page "2"
