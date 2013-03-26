Feature:

	In order to know about the social surroundings
	As a User
	I want to be able to view my connections on my mobile device

Background:

	Given I make a new USSD login request
	And User "camfed_user" logs into USSD with correct credentials
	And User should see the USSD home page
	And User chooses the option "Connections"
	And User should see the connections menu with 0 connections and 0 requests

Scenario: Verify back from connections page from ussd
  And User replies to go back to previous menu
  Then User should see the USSD home page
  
	
Scenario: Verify back from connections page from ussd
    When User sends an invalid option "9"
    Then User returns with error "invalid_option"
    

