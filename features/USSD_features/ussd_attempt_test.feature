
@javascript
Feature:

	As a User
	I want to attempt a test

Scenario Outline: Student attempts a test
  Given the following test data with questions exists:
    |ROLE   |COURSE  |STATUS  |TESTS  |
    |<ROLE> |<COURSE>|<STATUS>|<TESTS>|
  And I make a new USSD login request
  And User "camfed_student" logs into USSD with correct credentials
  Then User should see the USSD home page
  Given User chooses the option "Courses"
  When User should see the courses list
  And User chooses course "1"
  Then User should see the tests for page "1"
  And User chooses test "1"
  Then User should see the "<ROLE>" menu
  When User choose attempt test
  Then User should see question "1"
  When User choose option "2"
  Then User should see question "2"
  When User choose option "#"
  Then User should see message "You have successfully finished the test"


Examples:
  |ROLE   |COURSE |STATUS|TESTS|
  |Student|Arts   |active|India|
