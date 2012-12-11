@javascript
Feature:

	As a User
	I want to view my score of a test

@stage
Scenario Outline: Student views score without attempting the test

  Given the following test data with questions exists:
    |ROLE   |COURSE  |STATUS  |TEST  |ATTEMPTS|QUESTIONS|
    |<ROLE> |<COURSE>|<STATUS>|<TEST>|<ATTEMPTS>|<QUESTIONS>|
  And I make a new USSD login request
  And User "camfed_user" logs into USSD with correct credentials
  And User navigates to test page and chooses test "1"
  Then User should see quiz menu for role "<ROLE>" having "<QUESTIONS>" questions and "<ATTEMPTS>" attempts
  Then User chooses "View Score"
  Then User should see the message "no_score"
  And User should see the "Back" option
  Then User chooses "Back" option
  Then User should see quiz menu for role "<ROLE>" having "<QUESTIONS>" questions and "<ATTEMPTS>" attempts

Examples:
  |ROLE   |COURSE      |STATUS|TEST         |ATTEMPTS|QUESTIONS|
  |Student|Chemistry   |active|Hybridization|1			 |2        |

@stage  
Scenario Outline: Student views score after attempting the test

  Given the following test data with questions exists:
    |ROLE   |COURSE  |STATUS  |TEST  |ATTEMPTS|QUESTIONS|
    |<ROLE> |<COURSE>|<STATUS>|<TEST>|<ATTEMPTS>|<QUESTIONS>|
  And I make a new USSD login request
  And User "camfed_user" logs into USSD with correct credentials
  And User navigates to test page and chooses test "1"
  Then User should see quiz menu for role "<ROLE>" having "<QUESTIONS>" questions and "<ATTEMPTS>" attempts
  When User chooses "Attempt Test"
  Then User should see question "1"
  When User chooses option "1"
  Then User should see question "2"
  When User skips the question
  Then the Quiz should be submitted
  And User should see the message "successful_test_attempt"
  Then User chooses option "0"
  And User chooses test "1"
  Then User chooses "View Score"
  Then User should see message "Score: 1 out of 2"
  
Examples:
  |ROLE   |COURSE |STATUS|TEST|ATTEMPTS|QUESTIONS|
  |Student|Chemistry   |active|AntiHistamines|1|2|
  
@manual
Scenario: Verify invalid option throws an appropriate error

@wip
Scenario: Teacher views test info without any student attempting the test

@wip
Scenario: Teacher views test info with a student attempting the test

@wip
Scenario: Student attempts available is updated after attempting a Multiple Attempt test on test info

@wip
Scenario: Verify attempts available is updated after a student has taken the test on test info

