@javascript
Feature:

	In order to know the courses I have enrolled for
	As a User
	I want to be able to view the list of my courses on my mobile device

Background:

	Given I make a new USSD login request
	When User "camfed_user" logs into USSD with correct credentials
	Then User should see the USSD home page

@stage
Scenario: View Courses list when User is enrolled as both teacher and student
Given User "camfed_user" is enrolled with following courses:
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

Scenario: User is not enrolled to any course
	When User chooses the option "Courses"
	Then User should see the message "no_course_attached"
	And User should not see "Previous" and "Next" option

Scenario: User is enrolled as an observer
  Given User "camfed_user" is enrolled with following courses:
   |COURSE     |ROLE     |STATUS|
   |History    |Observer |active|
   |Physics    |Observer |pending|
   When User chooses the option "Courses"
   Then User should see the message "no_course_attached"
   And User should not see "Previous" and "Next" option

@stage
Scenario: Verify that error is given to the user when she enters an invalid option	
Given User "camfed_user" is enrolled with following courses:
 |COURSE     |ROLE    |STATUS|
 |History    |Student |pending|
 |Physics    |Teacher |active|
 |Geography  |Student |active|
 |Maths      |Teacher |active|
 |Biology    |Student |pending|
	Given User chooses the option "Courses"
	Given User sends an invalid option "5"
  Then User returns with error "invalid_option"
	
Scenario: Verify courses are not repeated at multiples of four

Given User "camfed_user" is enrolled with following courses:
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
  Then User returns with error "invalid_option"

Scenario: Verify unpublished courses are not visible

  Given User "camfed_user" is enrolled with following courses:
    |COURSE     |ROLE    |STATUS|
    |Physics    |Teacher |active|
  And User "camfed_user" is enrolled with following unpublished courses:
    |COURSE     |ROLE    |STATUS|
    |Chemistry    |Teacher |active|
  Given User chooses the option "Courses"
  Then User should see the courses list

Scenario: Verify that the order of courses in the list is correct with pagination

  Given User "camfed_user" is enrolled with following courses:
    |COURSE     |ROLE    |STATUS|
    |Physics1    |Teacher |active|
    |Physics2    |Teacher |active|
    |Physics3    |Teacher |active|
    |Physics4    |Teacher |active|
    |Physics5    |Teacher |active|
    |Physics6    |Teacher |active|
    |Physics7    |Teacher |active|
    |Physics8    |Teacher |active|
    |Physics9    |Teacher |active|
    |Physics10   |Teacher |active|
    |Physics11   |Teacher |active|
  Given User chooses the option "Courses"
  Then User should see home as the last option
  When User chooses the "Next" option
  When User chooses the "Next" option
  Then User should see the courses list in correct order
