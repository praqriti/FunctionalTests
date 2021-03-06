@javascript
Feature:

	As a User
	I want to attempt a test

Scenario Outline: Student attempts a single attempt test once

  Given the following test data with questions exists:
    |ROLE   |COURSE  |STATUS  |TEST  |ATTEMPTS|QUESTIONS|
    |<ROLE> |<COURSE>|<STATUS>|<TEST>|<ATTEMPTS>|<QUESTIONS>|
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
   |ROLE   |COURSE      |STATUS|TEST    |ATTEMPTS|QUESTIONS|
   |Student|Arts        |active|India   |1			 |2        |
  
@stage  
Scenario Outline: Student attempts a single attempt test twice

	Given the following test data with questions exists:
    |ROLE   |COURSE  |STATUS  |TEST  |ATTEMPTS|QUESTIONS|
    |<ROLE> |<COURSE>|<STATUS>|<TEST>|<ATTEMPTS>|<QUESTIONS>|
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
	Then User replies to go back to previous menu
	And User chooses test "1"
	When User chooses "Attempt Test"
	Then User should see the message "single_attempt"
	
Examples:
  |ROLE   |COURSE      |STATUS|TEST    |ATTEMPTS|QUESTIONS|
  |Student|Anthropology|active|Pakistan|1				|2        |

@stage  
Scenario Outline: Student chooses an invalid option while attempting test

	Given the following test data with questions exists:
    |ROLE   |COURSE  |STATUS  |TEST  |ATTEMPTS|QUESTIONS|
    |<ROLE> |<COURSE>|<STATUS>|<TEST>|<ATTEMPTS>|<QUESTIONS>|
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
    |ROLE   |COURSE      |STATUS|TEST    |ATTEMPTS|QUESTIONS|
    |Student|Science     |active|Biology |1				|2        |

Scenario Outline: Student attempts a test with no questions

	Given the following test data with questions exists:
    |ROLE   |COURSE  |STATUS  |TEST  |ATTEMPTS|QUESTIONS|
    |<ROLE> |<COURSE>|<STATUS>|<TEST>|<ATTEMPTS>|<QUESTIONS>|
  And I make a new USSD login request
  And User "camfed_user" logs into USSD with correct credentials
  And User navigates to test page and chooses test "1"
  Then User should see quiz menu for role "<ROLE>" having "<QUESTIONS>" questions and "<ATTEMPTS>" attempts
  When User chooses "Attempt Test"
  Then User should see the message "no_question_added_to_quiz"
  When User replies to go back to previous menu
  Then User should see the tests for page "1"

  Examples:
    |ROLE   |COURSE      |STATUS|TEST    |ATTEMPTS|QUESTIONS|
    |Student|Science     |active|Biology |1		  |0        |
