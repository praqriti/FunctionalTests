Feature:

	In order to access my profile 
	As an user
	I want to login to the system using my mobile device

Scenario: Verify login from USSD

	Given I make a new USSD login request
	When User "camfed_student" logs into USSD with her credentials
	Then User should see the USSD home page

  
Scenario Outline: Verify Incorrect login details

	Given I make a new USSD login request
	When User "<USER>" logs in with "<PASSWORD>"
	Then I should be informed that my username and password is incorrect

	Examples:
	| USER         | PASSWORD     | 
	| camfed_today | password_two | 
	| camfed_today |              |
	|              | password_two |
	|              |              |
	| camfed_today | password_two |






