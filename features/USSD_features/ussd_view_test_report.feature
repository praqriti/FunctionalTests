@javascript
Feature:

	As a User
	I want to view my score of a test

@stage
Scenario Outline: Teacher Views a test report

  Given the following test data with questions exists:
    |ROLE   |COURSE  |STATUS  |TEST  |
    |<ROLE> |<COURSE>|<STATUS>|<TEST>|
  And I make a new USSD login request
  And User "camfed_user" logs into USSD with correct credentials
  And User navigates to test page and chooses test "1"
  Then User should see quiz menu for role "<ROLE>" having "2" questions
  Then User chooses "View Report"
  Then User should see the message "no_score"
  And User should see the "Back" option
  Then User chooses "Back" option
  Then User should see quiz menu for role "<ROLE>" having "2" questions

Examples:
  |ROLE   |COURSE      |STATUS|TEST|
  |Teacher|Chemistry   |active|Hybridization|
