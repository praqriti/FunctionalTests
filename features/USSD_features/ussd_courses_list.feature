@javascript
Feature:

	In order to know the courses I have enrolled for
	As a User
	I want to be able to view the list of my courses on my mobile device

Background:

	Given I make a new USSD login request
	When User "camfed_student" logs into USSD with her credentials
	Then User should see the USSD home page


Scenario: View Courses list when User is enrolled as both teacher and student
Given User "camfed_student" is enrolled with following courses:
 |COURSE     |ROLE    |STATUS|
 |History    |Student |pending|
 |Physics    |Teacher |active|
 |Geography  |Student |active|
 |Maths      |Teacher |active|
 |Biology    |Student |pending|
 |Geology    |Teacher |active|
 |Archeology |Student |active|
 |Architechture |Teacher |pending|
 |Zoology    |Student |active|
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
	When User replies "0" to go back to home page
	Then User should see the USSD home page
	
@manual
Scenario: Verify that the order of courses in the list is correct with pagination

Scenario: User is not enrolled to any course
	When User chooses the option "Courses"
	Then User should see the message "no_course_attached"
	And User should not see "Previous" and "Next" option

@wip
Scenario: User is enrolled as an observer
  Given User "camfed_student" is enrolled with following courses:
   |COURSE     |ROLE     |STATUS|
   |History    |Observer |active|
   When User chooses the option "Courses"
   Then User should see the message "no_course_attached"
   And User should not see "Previous" and "Next" option

Scenario: Verify that error is given to the user when she enters an invalid option	
Given User "camfed_student" is enrolled with following courses:
 |COURSE     |ROLE    |STATUS|
 |History    |Student |pending|
 |Physics    |Teacher |active|
 |Geography  |Student |active|
 |Maths      |Teacher |active|
 |Biology    |Student |pending|
	Given User chooses the option "Courses"
	Given User sends an invalid option "5"
  Then User returns to home page with error "invalid_option"
	
#bug 295
Scenario: Verify courses are not repeated at multiples of four

Given User "camfed_student" is enrolled with following courses:
 |COURSE     |ROLE    |STATUS|
 |History    |Student |pending|
 |Physics    |Teacher |active|
 |Geography  |Student |active|
 |Maths      |Teacher |active|
	Given User chooses the option "Courses"
	Then User replies "0" to go back to home page
	And User chooses the option "Courses"
	Then User should see the courses list
	And User should not see "Previous" and "Next" option
	When User chooses the "Next" option
  Then User returns to home page with error "invalid_option"
