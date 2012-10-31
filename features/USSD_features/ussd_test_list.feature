@javascript
Feature:

	In order to attempt a test or view scores of test
	As a User
	I want to be able to view list of tests attached to my courses

Background:

	Given I make a new USSD login request
	When User "camfed_student" logs into USSD with her credentials
	Then "camfed_student" should see the USSD home page
	Given the following courses exist in canvas
	|COURSE|
	|History|
	And User navigates to quiz page of "History" course and creates following quiz
	|TEST|
	|Indian Independence|
	|World War 5|
	|World War 6|
	|World War 7|
	|World War 8|


Scenario: Teacher Menu option displayed for a test in a course
	When User is enrolled to the following courses as "teacher"
	|COURSE|
	|History|
	Given User chooses the option "Courses"
	When User should see the courses list
	And User chooses course "1"
	Then User should see the tests for page "1"
	And User chooses test "1"
	Then User should see the teachers menu

Scenario: Student Menu option displayed for a test in a course
	When User is enrolled to the following courses as "student"
	|COURSE|
	|History|
	Given User chooses the option "Courses"
	When User should see the courses list
	And User chooses course "1"
	Then User should see the tests for page "1"
	And User chooses test "1"
	Then User should see the students menu

Scenario: User can view all pages on tests list
	When User is enrolled to the following courses as "student"
	|COURSE|
	|History|
	Given User chooses the option "Courses"
	When User should see the courses list
	And User chooses course "1"
	Then User should see the tests for page "1"
	Then User should see the "Next" option on tests list
	When User chooses the "Next" option
	Then User should see the tests for page "2"
	Then User should see the "Previous" option on tests list
	When User chooses the "Previous" option
	Then User should see the tests for page "1"

Scenario: Verify back from tests page from ussd
	When User is enrolled to the following courses as "teacher"
	|COURSE|
	|History|
	Given User chooses the option "Courses"
	When User should see the courses list
	And User chooses course "1"
	Then User should see the tests for page "1"
	When User replies "0" from tests page to go back to home page
	Then "camfed_student" should see the USSD home page

Scenario: Verify that error is given to the user when she enters an invalid option

	When User is enrolled to the following courses as "teacher"
	|COURSE|
	|History|
	Given User chooses the option "Courses"
	When User should see the courses list
	And User chooses course "1"
	Then User should see the tests for page "1"	
	Given User sends an invalid option "9"
	Then User is given an error message and returns to home page
