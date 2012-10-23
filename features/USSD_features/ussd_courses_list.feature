
Feature:

	In order to know the courses I have enrolled for
	As a User
	I want to be able to view the list of my courses on my mobile device

Background:

	Given I make a new USSD login request
	When User "camfed_student" logs into USSD with her credentials
	Then "camfed_student" should see the USSD home page

Scenario: View Courses list
	
	Given the following courses exist in canvas
	|COURSE|
	|History|
	|Chemistry|
	|Mathematics|
	|Computer|
	And User is enrolled to the following courses
	|COURSE|
	|History|
	|Chemistry|
	Given User chooses the option "Courses"
	Then User should see the courses list
	Then the created courses are deleted
@wip	
Scenario: Verify back from courses page from ussd
	
	Given User chooses the option "Courses"
	And User should see the courses list
	When User replies "0" from courses page to go back to home page
	Then "camfed_student" should see the USSD home page
