@javascript
Feature:

	In order to know the Groups I have enrolled for
	As a User
	I want to be able to view the list of my groups on my mobile device

Background:

	Given I make a new USSD login request
	When User "camfed_user" logs into USSD with correct credentials
	Then User should see the USSD home page

Scenario: View list of groups to which user is attached
  Given User "camfed_user" is enrolled with following groups:
   |name         |
   |History      |
   |Physics      |
   |Geography    |
   |Maths        |
   |Biology      |
   |Geology      |
   |Archeology   |
   |Architechture|
   |Zoology      |
	Given User chooses the option "Groups"
	Then User should see the groups list on page "1"
	When User chooses the "Next" option
	Then User should see the groups list on page "2"
	And User should see the "Next" and "Previous" option
	When User chooses the "Next" option
	Then User should see the groups list on page "3"
	And User should see the "Previous" option
	When User chooses the "Previous" option
	Then User should see the groups list on page "2"
	And User should see the "Next" and "Previous" option
	When User replies "0" to go back to home page
	Then User should see the USSD home page

Scenario: View the group menu when user selects the group
  Given User "camfed_user" is enrolled with following groups:
   |name         |
   |History      |
   |Physics      |
   |Geography    |
	Given User chooses the option "Groups"
	Then User should see the groups list on page "1"
    When User chooses the group "History"
    Then User should see the group menu page
    And User should see the "Back" option
    When User chooses the "Previous" option
    Then User should see the groups list on page "1"

