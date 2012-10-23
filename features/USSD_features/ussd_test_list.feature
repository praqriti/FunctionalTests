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

Scenario: Teacher Menu option displayed for a test in a course

  When User is enrolled to the following courses as "teacher"
    |COURSE|
    |History|
  And User publishes the course "History"
  And User navigates to quiz page and creates following quiz
    |TEST|
    |Indian Independence|
    |World War 5|
    |World War 6|
    |World War 7|
    |World War 8|
    Given User chooses the option "Courses"
    When User should see the courses list
    And User chooses the first course
    Then User should see the tests for page 1
    And User chooses the first test
    Then User should see the teachers menu

@wip
Scenario: Student Menu option displayed for a test in a course

  When User is enrolled to the following courses as "student"
    |COURSE|
    |History|
  And User publishes the course "History"
  And User navigates to quiz page and creates following quiz
    |TEST|
    |Indian Independence|
    |World War 5|
    |World War 6|
    |World War 7|
    |World War 8|
  Given User chooses the option "Courses"
  When User should see the courses list
  And User chooses the first course
  Then User should see the tests for page 1
  And User chooses the first test
  Then User should see the teachers menu
