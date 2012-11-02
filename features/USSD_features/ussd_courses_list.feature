
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
	|Biology |
	And User is enrolled to the following courses as "teacher"
	|COURSE|
	|History|
	|Chemistry|
	|Mathematics|
	Given User chooses the option "Courses"
	Then User should see the courses list
	And User should not see "Previous" and "Next" option

Scenario: View Courses list when User is enrolled as both teacher and student
	Given the following courses exist in canvas
	|COURSE|
	|History|
	|Chemistry|
	|Mathematics|
	|Computer|
	|Biology |
	And User is enrolled to the following courses as "teacher"
	|COURSE|
	|History|
	|Mathematics|
	And User is enrolled to the following courses as "student"
	|COURSE|
	|Chemistry|
	|Biology|
	Given User chooses the option "Courses"
	Then User should see the courses list
	And User should not see "Previous" and "Next" option

Scenario: View all pages of Courses list when there are a total of 3 pages
	Given the following courses exist in canvas
	|COURSE|
	|History|
	|Chemistry|
	|Mathematics|
	|Computer|
	|Biology |
	|Physics |
	|English |
	|Portuguese |
	|Punjabi |
	And User is enrolled to the following courses as "student"
	|COURSE|
	|History|
	|Chemistry|
	|Mathematics|
	|Computer|
	|Biology |
	|Physics |
	|English |
	|Portuguese |
	|Punjabi |
	Given User chooses the option "Courses"
	Then User should see the courses list on page "1"
	And User should see the "Next" option
	When User chooses the "Next" option
	Then User should see the courses list on page "2"
	And User should see the "Next" and "Previous" option
	When User chooses the "Next" option
	Then User should see the courses list on page "3"
	And User should see the "Previous" option
	When User chooses the "Previous" option
	Then User should see the courses list on page "2"

Scenario: Verify back from courses page from ussd

	Given the following courses exist in canvas
	|COURSE|
	|History|
	|Chemistry|
	|Mathematics|
	|Computer|
    	And User is enrolled to the following courses as "teacher"
	|COURSE|
	|History|
	|Chemistry|
	Given User chooses the option "Courses"
	And User should see the courses list
	When User replies "0" from courses page to go back to home page
	Then "camfed_student" should see the USSD home page

@manual
Scenario: Verify that the order of courses in the list is correct

	Given the following courses exist in canvas
	|COURSE|
	|History|
	|Chemistry|
	|Mathematics|
	|Computer|
	|Biology |
	|Physics |
	|English |
	|Portuguese |
	|Punjabi |
	|Refactoring|
	|Object Oriented|
	|Business logic|
	And User is enrolled to the following courses as "student"
	|COURSE|
	|History|
	|Chemistry|
	|Mathematics|
	|Computer|
	|Biology |
	|Physics |
	|English |
	|Portuguese |
	|Punjabi |
	|Refactoring|
	|Object Oriented|
	|Business logic|
	Given User chooses the option "Courses"
	Then User should see the courses list on page "1"
	And the ordering of courses on page "1" should be correct
	And User should see the "Next" option
	When User chooses the "Next" option
	Then User should see the courses list on page "2"
	And the ordering of courses on page "2" should be correct
	And User should see the "Next" and "Previous" option
	When User chooses the "Next" option
	Then User should see the courses list on page "3"
	And the ordering of courses on page "3" should be correct
	And User should see the "Previous" option

Scenario: User is not enrolled to any course

	Given User chooses the option "Courses"
	Then "No Course Attached" should be displayed to the User

Scenario: User is enrolled to courses as student and Observer

	Given the following courses exist in canvas
	|COURSE|
	|History|
	|Chemistry|
	And User is enrolled to the following courses as "student"
	|COURSE|
	|History|
	And User is enrolled to "Chemistry" as "Observer" with pending invitation
	When User chooses the option "Courses"
	Then User should only see course "History"

Scenario: User is enrolled to courses as Observer

	Given the following courses exist in canvas
	|COURSE|
	|History|
	|Chemistry|
	And User is enrolled to "Chemistry" as "Observer" with pending invitation
	Given User chooses the option "Courses"
	Then "No Course Attached" should be displayed to the User

Scenario: Verify that error is given to the user when she enters an invalid option
	
	Given the following courses exist in canvas
	|COURSE|
	|History|
	|Chemistry|
	|Mathematics|
	|Computer|
	|Biology |
	And User is enrolled to the following courses as "teacher"
	|COURSE|
	|History|
	|Chemistry|
	|Mathematics|
	Given User chooses the option "Courses"
	Then User should see the courses list
	Given User sends an invalid option "9"
	Then User is given an error message and returns to home page

#bug 295
Scenario: Verify courses are not repeated at multiples of four

	Given the following courses exist in canvas
	|COURSE|
	|History|
	|Chemistry|
	|Mathematics|
	|Computer|
	|Biology |
	And User is enrolled to the following courses as "teacher"
	|COURSE|
	|History|
	|Chemistry|
	|Mathematics|
	|Computer|
	Given User chooses the option "Courses"
	Then User should see the courses list
	Then User replies "0" from courses page to go back to home page
	And User chooses the option "Courses"
	Then User should see the courses list
	When User chooses the "Next" option
	Then User is given an error message and returns to home page
