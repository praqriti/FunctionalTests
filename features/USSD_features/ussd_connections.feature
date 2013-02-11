Feature:

	In order to know about the social surroundings
	As a User
	I want to be able to view my connections on my mobile device

Background:

	Given I make a new USSD login request
	And User "camfed_user" logs into USSD with correct credentials
	And User should see the USSD home page
	And User chooses the option "Connections"
	And User should see the connections menu

Scenario: Verify back from connections page from ussd	
	When User replies "0" to go back to home page
	Then User should see the USSD home page
  
	
Scenario: Verify back from connections page from ussd
    When User sends an invalid option "9"
    Then User returns with error "invalid_option"
    

