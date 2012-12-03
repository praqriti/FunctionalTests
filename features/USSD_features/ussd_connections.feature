Feature:

	In order to know about the social surroundings
	As a User
	I want to be able to view my connections on my mobile device

Background:

	Given I make a new USSD login request
	When User "camfed_user" logs into USSD with correct credentials
	Then User should see the USSD home page

Scenario: View connections menu

	Given User chooses the option "Connections"
	Then User should see the connections menu

Scenario: Verify back from connections page from ussd
	
	Given User chooses the option "Connections"
	And User should see the connections menu
	When User replies "0" from connections page to go back to home page
	Then User should see the USSD home page

