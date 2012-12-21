@javascript
Feature:

	In order to know the announcements I have enrolled for
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
	Then User should see the ordered groups list on page "1"
	When User chooses group "1"
	Then User should see the USSD home page