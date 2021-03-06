@javascript
Feature:

	In order to attempt a test or view scores of test
	As a User
	I want to be able to view list of tests attached to my courses

@stage
Scenario Outline: Verify Menu option is displayed with pagination for a test in a course
  Given the following test data with questions exists:
    |ROLE   |COURSE  |STATUS  |TEST  |ATTEMPTS|QUESTIONS|
    |<ROLE> |<COURSE>|<STATUS>|<TEST>|<ATTEMPTS>|<QUESTIONS>|
  And I make a new USSD login request
  And User "camfed_user" logs into USSD with correct credentials
  Then User should see the USSD home page
  Given User chooses the option "Courses"
  When User should see the courses list
  And User chooses course "1"
  Then User should see the tests for page "1"
  When User chooses the "Next" option
  Then User should see the tests for page "2"
  When User chooses the "Previous" option
  Then User should see the tests for page "1"
  And User chooses test "1"
  Then User should see quiz menu for role "<ROLE>" having "<QUESTIONS>" questions and "<ATTEMPTS>" attempts

Examples:
 |ROLE   |COURSE |STATUS|TEST                                                              |ATTEMPTS|QUESTIONS|
 |Teacher|History|active|Indian Independence,World War 1,World War 2,World War 3,World War 4|1       |0        |
 |Student|Arts   |active|India,World Wars,Sculpting,Sword Fighting,Painting                 |1       |0        |

@stage
Scenario: Verify that error is given to the user when she enters an invalid option
  Given the following test data with questions exists:
    |ROLE   |COURSE |STATUS|TEST|
    |Student|Maths  |active|Algebra|
  And I make a new USSD login request
  And User "camfed_user" logs into USSD with correct credentials
  When User should see the USSD home page
  And User chooses the option "Courses"
  And User should see the courses list
  And User chooses course "1"
  And User sends an invalid option "9"
  Then User returns with error "invalid_option"
