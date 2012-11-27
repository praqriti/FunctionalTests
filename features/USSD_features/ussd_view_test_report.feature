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
    Then User chooses "View Report"
    Then User should see the test report:
    |HIGH_SCORE|LOW_SCORE|AVERAGE|MEAN|STUDENTS_ATTEMPTED|
    |0.0       |0.0      |0      |0.0 |0                 |
    And User should see the "Back" option
    Then User chooses "Back" option
    Then User should see quiz menu for role "<ROLE>" having "<QUESTIONS>" questions and "<ATTEMPTS>" attempts

  Examples:
    |ROLE   |COURSE      |STATUS|TEST         |ATTEMPTS |QUESTIONS|
    |Teacher|Chemistry   |active|Hybridization|1        |2        |
