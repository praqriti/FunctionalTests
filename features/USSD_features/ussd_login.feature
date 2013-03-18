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
	

Scenario Outline: User should see the ussd app in language of his preference
  Given the following users exists in canvas:
  | USER          | LOCALE      |
  | <USER>        | <LOCALE>    |
  Given I make a new USSD login request
  When User "<USER>" logs into USSD with correct credentials
  Then User should see the USSD home page in "<LOCALE>"  
  Examples:
   |     USER      | LOCALE|
   | camfed_user_1 | sw    |
   | camfed_user   | en    |
   
@manual
 Scenario: One user cannot continue with other users access token
 
