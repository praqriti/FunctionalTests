@wip
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
    And User is enrolled to the following courses
      |COURSE|
      |History|

Scenario: List of tests in the courses attached to User should be displayed

    Given User chooses the option "Courses"
    When User should see the courses list
    And User chooses the first course
    Then User should see the tests
