@javascript
Feature:

	As a User
	I want to attempt a test

Scenario Outline: Student attempts a single attempt test once

  Given the following test data with questions exists:
    |ROLE   |COURSE  |STATUS  |TEST  |ATTEMPTS|
    |<ROLE> |<COURSE>|<STATUS>|<TEST>|<ATTEMPTS>|
  And I make a new USSD login request
  And User "camfed_user" logs into USSD with correct credentials
  And User navigates to test page and chooses test "1"
  Then User should see quiz menu for role "<ROLE>" having "<QUESTIONS>" questions and "<ATTEMPTS>" attempts
  When User chooses "Attempt Test"
  Then User should see question "1"
  When User chooses option "2"
  Then User should see question "2"
  When User skips the question
  Then the Quiz should be submitted
  And User should see the message "successful_test_attempt"


Examples:
   |ROLE   |COURSE      |STATUS|TEST    |QUESTIONS|ATTEMPTS|
   |Student|Arts        |active|India   |2        |1       |
  
@stage  
Scenario Outline: Student attempts a single attempt test twice

	Given the following test data with questions exists:
    |ROLE   |COURSE  |STATUS  |TEST  |ATTEMPTS|
    |<ROLE> |<COURSE>|<STATUS>|<TEST>|<ATTEMPTS>|
  And I make a new USSD login request
  And User "camfed_user" logs into USSD with correct credentials
  And User navigates to test page and chooses test "1"
  Then User should see quiz menu for role "<ROLE>" having "<QUESTIONS>" questions and "<ATTEMPTS>" attempts
  When User chooses "Attempt Test"
  Then User should see question "1"
  When User chooses option "2"
  Then User should see question "2"
  When User skips the question
  Then the Quiz should be submitted
  And User should see the message "successful_test_attempt"
	Then User chooses "Back" option
	And User chooses test "1"
	When User chooses "Attempt Test"
	Then User should see the message "single_attempt"
	
Examples:
  |ROLE   |COURSE      |STATUS|TEST    |QUESTIONS|ATTEMPTS|
  |Student|Anthropology|active|Pakistan|2        |1       |

@stage  
Scenario Outline: Student chooses an invalid option while attempting test

	Given the following test data with questions exists:
    |ROLE   |COURSE  |STATUS  |TEST  |ATTEMPTS|
    |<ROLE> |<COURSE>|<STATUS>|<TEST>|<ATTEMPTS>|
  And I make a new USSD login request
  And User "camfed_user" logs into USSD with correct credentials
  And User navigates to test page and chooses test "1"
  Then User should see quiz menu for role "<ROLE>" having "<QUESTIONS>" questions and "<ATTEMPTS>" attempts
  When User chooses "Attempt Test"
  Then User should see question "1"
  When User chooses option "6"
  Then User should see message "Invalid Option"
  Then User should see question "1"
  When User chooses option "2"
  Then User should see question "2"
  When User skips the question
  Then the Quiz should be submitted
  And User should see the message "successful_test_attempt"
  Then User chooses option "5"
  Then User should see message "Invalid Option"
  
  Examples:
    |ROLE   |COURSE      |STATUS|TEST    |QUESTIONS|ATTEMPTS|
    |Student|Science     |active|Biology |2        |2       |
