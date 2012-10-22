@wip
Feature:

	In order to attempt a test or view scores of test
	As a User
	I want to be able to view list of tests attached to my courses

Background:

	Given I make a new USSD login request
	When User "camfed_student" logs into USSD with her credentials
	Then "camfed_student" should see the USSD home page

Scenario: List of tests in the courses attached to User should be displayed 

	Given User chooses the option "Courses"
	Then User should see the courses list in alphabetical order
	When User selects first course
	Then User should see the course name followed by list of tests attached to that course in order of due date
