@javascript
Feature:

	In order to attempt a test or view scores of test
	As a User
	I want to be able to view list of tests attached to my courses
	
Scenario Outline: Verify Menu option is displayed with pagination for a test in a course
Given the following test data exists:
 |USER          |ROLE   |COURSE  |STATUS  |GROUP  |TESTS  |
 |<USER>        |<ROLE> |<COURSE>|<STATUS>|<GROUP>|<TESTS>|
 And I make a new USSD login request
 And User "<USER>" logs into USSD with her credentials
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
 Then User should see the "<ROLE>" menu
 When User replies "0" from tests page to go back to home page
 Then User should see the USSD home page

Examples:
|USER               |ROLE   |COURSE |STATUS|GROUP|TESTS|
|camfed_quiz_teacher|Teacher|History|active|USSD |Indian Independence,World War 1,World War 2,World War 3,World War 4|
|camfed_quiz_student|Student|History|active|USSD |Indian Independence,World War 1,World War 2,World War 3,World War 4|


Scenario: Verify that error is given to the user when she enters an invalid option
 Given the following test data exists:
 |USER               |ROLE   |COURSE |STATUS|GROUP|TESTS|
 |camfed_quiz_student|Student|Maths  |active|USSD |Algebra|
 And I make a new USSD login request
 And User "camfed_quiz_student" logs into USSD with her credentials
 When User should see the USSD home page 
  And User chooses the option "Courses"
  And User should see the courses list
  And User chooses course "1"
  Then User should see the tests for page "1" 
  And User sends an invalid option "9"
  Then User returns to home page with error "invalid_option"
	
