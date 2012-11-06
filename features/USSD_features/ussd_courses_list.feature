@javascript
Feature:

	In order to know the courses I have enrolled for
	As a User
	I want to be able to view the list of my courses on my mobile device

Background:

	Given I make a new USSD login request
	When User "camfed_student" logs into USSD with her credentials
	Then "camfed_student" should see the USSD home page


Scenario: View Courses list when User is enrolled as both teacher and student
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
	Given User is enrolled to the following courses:
	|COURSE   |ROLE|
	|History  |Teacher|
	|Chemistry   |Teacher|
	|Mathematics   |Teacher|
	|Biology |Teacher|
	|Physics |Student|
	|English |Student|
	|Punjabi |Student|
	|Computer  |Student|
  |Portuguese |Student|
	Given User chooses the option "Courses"
	Then User should see the courses list on page "1"
	When User chooses the "Next" option
	Then User should see the courses list on page "2"
	And User should see the "Next" and "Previous" option
	When User chooses the "Next" option
	Then User should see the courses list on page "3"
	And User should see the "Previous" option
	When User chooses the "Previous" option
	Then User should see the courses list on page "2"
	And User should see the "Next" and "Previous" option
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
	When User chooses the option "Courses"
	Then "No Course Attached" should be displayed to the User
	And User should not see "Previous" and "Next" option

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
