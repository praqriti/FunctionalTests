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
    And User "camfed_user" is connected to:
      |USER|
      |connected_user1|
      |connected_user2|
      |connected_user3|
      |connected_user4|
      |connected_user5|
    

Scenario: View connected connections
    And I make a new USSD login request
    When User "camfed_user" logs into USSD with correct credentials
    Then User should see the USSD home page
    Given User chooses the option "Connections"
    Then User should see the connections menu
    When User chooses option "1"
    Then User should see the list of connected users for page "1"
    When User chooses the "Next" option
    Then User should see the list of connected users for page "2"
    When User chooses the "Previous" option
    Then User should see the list of connected users for page "1"
    And User replies "0" to go back to home page
    Then User should see the USSD home page
    

Scenario: Verify if removing a user from web reflects on USSD app and no pagination is visible
       When User is on the Sign In page
       When User "camfed_user" logs into Canvas with her credentials
       When User navigates to "My Connections" page
       Then User can see "5" connections available
       When User navigates to "My Connections" page
       And User can "disconnect" his connection "connected_user5"
       And User confirms the disconnection "connected_user5"
       Then User can see "4" connections available
       Then User logs out
       And I make a new USSD login request
   	   When User "camfed_user" logs into USSD with correct credentials
   	   Then User should see the USSD home page
       Given User chooses the option "Connections"
       Then User should see the connections menu
       When User chooses option "1"
       Then User should see the list of connected users for page "1"
       And User should not see "Previous" and "Next" option
   
Scenario: Verify invalid option from connected connections page from ussd
       And I make a new USSD login request
       When User "camfed_user" logs into USSD with correct credentials
       Then User should see the USSD home page
       Given User chooses the option "Connections"
       Then User should see the connections menu
       When User chooses option "1"
       And User should see the list of connected users for page "1"
       And User sends an invalid option "9"
       Then User returns with error "invalid_option"
       

