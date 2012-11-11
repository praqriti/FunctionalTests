@javascript
Feature:

	As a User
	I want to attempt a test

Scenario Outline: Student attempts a single attempt test once

  Given the following test data with questions exists:
    |ROLE   |COURSE  |STATUS  |TESTS  |
    |<ROLE> |<COURSE>|<STATUS>|<TESTS>|
  And I make a new USSD login request
  And User "camfed_user" logs into USSD with correct credentials
  And User navigates to test page and chooses test "1"
  Then User should see the "<ROLE>" menu
  When User chooses attempt test
  Then User should see question "1"
  When User chooses option "2"
  Then User should see question "2"
  When User chooses option "#"
  Then User should see message "You have successfully finished the test"


Examples:
  |ROLE   |COURSE |STATUS|TESTS|
  |Student|Arts   |active|India|
  
Scenario Outline: Student attempts a single attempt test twice

	Given the following test data with questions exists:
    |ROLE   |COURSE  |STATUS  |TESTS  |
    |<ROLE> |<COURSE>|<STATUS>|<TESTS>|
  And I make a new USSD login request
  And User "camfed_user" logs into USSD with correct credentials
  And User navigates to test page and chooses test "1"
  Then User should see the "<ROLE>" menu
  When User chooses attempt test
  Then User should see question "1"
  When User chooses option "2"
  Then User should see question "2"
  When User chooses option "#"
  Then User should see message "You have successfully finished the test"
	Then User chooses option "0"
	And User chooses test "1"
	Then User should see message "This was single attempt test and you have already attempted the test"
	
Examples:
  |ROLE   |COURSE |STATUS|TESTS|
  |Student|Anthropology|active|Pakistan|
  
Scenario Outline: Student chooses an invalid option while attempting test

	Given the following test data with questions exists:
    |ROLE   |COURSE  |STATUS  |TESTS  |
    |<ROLE> |<COURSE>|<STATUS>|<TESTS>|
  And I make a new USSD login request
  And User "camfed_user" logs into USSD with correct credentials
  And User navigates to test page and chooses test "1"
  Then User should see the "<ROLE>" menu
  When User chooses attempt test
  Then User should see question "1"
  When User chooses option "6"
  Then User should see message "Invalid Option"
  Then User should see question "1"
  When User chooses option "2"
  Then User should see question "2"
  When User chooses option "#"
  Then User should see message "You have successfully finished the test"
  Then User chooses option "5"
  Then User should see message "Invalid Option"
  
Examples:
  |ROLE   |COURSE |STATUS|TESTS|
  |Student|Terrorism|active|Pakistan|
