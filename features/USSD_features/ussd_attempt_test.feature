@wip
@javascript
Feature:

	As a User
	I want to attempt a test

Scenario: Student attempts a test
  Given the following test with questions exists:
  |USER          |ROLE   |COURSE |TEST|
  |camfed_quiz_student|Student|History|Indian Independence|
  And I make a new USSD login request
  And User "camfed_quiz_student" logs into USSD with her credentials
  Then "camfed_quiz_student" should see the USSD home page
  Given User chooses the option "Courses"
  When User should see the courses list
  And User chooses course "1"
  Then User should see the tests for page "1"
  And User chooses test "1"
  Then User should see the students menu
  When User choose attempt test
  Then User should see question "1"
  When User choose option "2"
  Then User should see question "2"
  When User choose option "$"
  Then User should see message "You have successfully finished the test"