Feature:

	In order to access my profile 
	As an user
	I want to login to the system using my mobile device

Scenario: Verify login from USSD

	Given I make a new USSD login request
	When User "camfed_user" logs into USSD with correct credentials
	Then User should see the USSD home page

  
Scenario Outline: Verify Incorrect login details

	Given I make a new USSD login request
	When User "<USER>" logs into USSD with password "<PASSWORD>"
	Then I should be informed that my username and password is incorrect

	Examples:
	| USER         | PASSWORD     | 
	| camfed_today | password_two | 
	| camfed_today |              |
	|              | password_two |
	| camfed_today | password_two |
	
@manual
  Scenario: two users cannot use the same session ID
  
@manual
  Scenario: expiration of access token
  
@manual
  Scenario: One user cannot continue with other users access token

Scenario: User should see the ussd app in language of his preference
  Given the following users exists in canvas:
  |     USER      | LOCALE|
  | camfed_user_1 | sw    |
  | camfed_user   | en    |

  Given I make a new USSD login request
  When User "camfed_user_1" logs into USSD with correct credentials
  Then User should see the USSD home page in "sw"
  Given I make a new USSD login request
  When User "camfed_user" logs into USSD with correct credentials
  Then User should see the USSD home page in "en"
