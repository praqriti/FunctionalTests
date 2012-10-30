Feature:

	In order to know my enrollments in a course
	As a User
	I want to be able to view information about the course

Background:

	Given I make a new USSD login request
	When User "camfed_student" logs into USSD with her credentials
	Then "camfed_student" should see the USSD home page
	Given the following courses exist in canvas
	|COURSE|
	|History|
	|Chemistry|
	|Mathematics|
	|Computer|
	|Biology |
	|Chinese|
	And User is enrolled to the following courses as "teacher"
	|COURSE|
	|History|
	|Mathematics|
	And User is enrolled to the following courses as "student"
	|COURSE|
	|Chemistry|
	|Biology|
	And User is enrolled to "Computer" as "Student" with pending invitation
	And User is enrolled to "Chinese" as "Teacher" with pending invitation
	Given User chooses the option "Courses"
	Then User should see the courses list on page "1"

Scenario: User selects a course in which he is enrolled as teacher

	When User chooses course "1"
	Then User should see the message "Attached to course as Teacher\nNo Quiz Attached"

Scenario: User selects a course in which he is enrolled as student

	When User chooses course "3"
	Then User should see the message "Attached to course as Student\nNo Quiz Attached"

Scenario: User selects a course in which invitation is pending for student

	When User chooses the "Next" option
	And User chooses course "5"
	Then User should see the message "Attached to course as Student\nPlease log in to Web, to respond to Course request"

Scenario: User selects a course in which invitation is pending for teacher

	When User chooses the "Next" option
	And User chooses course "6"
	Then User should see the message "Attached to course as Teacher\nPlease log in to Web, to respond to Course request"
