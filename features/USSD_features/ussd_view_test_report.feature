@javascript
Feature:

	As a User
	I want to view my score of a test

  @stage
  Scenario Outline: Student views test report

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
    And User replies to go back to previous menu
    Then User should see quiz menu for role "<ROLE>" having "<QUESTIONS>" questions and "<ATTEMPTS>" attempts

  Examples:
    |ROLE   |COURSE      |STATUS|TEST         |ATTEMPTS |QUESTIONS|
    |Teacher|Chemistry   |active|Hybridization|1        |2        |
    
@manual
Scenario: Verify decimal places on the score page
    
    
  
