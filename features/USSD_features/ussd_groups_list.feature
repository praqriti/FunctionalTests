@javascript
Feature:

	In order to know the Groups I have enrolled for
	As a User
	I want to be able to view the list of my groups on my mobile device

Background:

	Given I make a new USSD login request
	When User "camfed_user" logs into USSD with correct credentials
	Then User should see the USSD home page

@wip
Scenario: View list of groups to which user is attached with pagination
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
   |Microbiology |
   |Theology     |
   |Literature   |
   |Anthropology |
	Given User chooses the option "Groups"
	Then User should see the ordered groups list on page "1"
	When User chooses the "Next" option
	Then User should see the ordered groups list on page "2"
	And User should see the "Next" and "Previous" option
	When User chooses the "Next" option
	Then User should see the ordered groups list on page "3"
	And User should see the "Next" and "Previous" option
	When User chooses the "Next" option
	Then User should see the ordered groups list on page "4"
	When User chooses the "Previous" option
	Then User should see the ordered groups list on page "3"
	And User should see the "Next" and "Previous" option
    And User replies to go back to previous menu
	Then User should see the USSD home page

Scenario: View the group menu when user selects the group
  Given User "camfed_user" is enrolled with following groups:
   |name         |
   |History      |
   |Physics      |
   |Geography    |
	Given User chooses the option "Groups"
	Then User should see the ordered groups list on page "1"
  When User chooses the group "History"
  Then User should see the group menu page
  And User replies to go back to previous menu
  Then User should see the ordered groups list on page "1"
  
  Scenario: Verify the account level groups on the groups list page
    Given User "camfed_user" is enrolled with following groups:
     |name        |type   |
     |Sports      |account|
     |Arts        |account|
     |Science     |account|
  	And User chooses the option "Groups"
  	When User should see the ordered groups list on page "1"
    When User chooses the group "Sports"
    And User should see the group menu page
    And User replies to go back to previous menu
    Then User should see the ordered groups list on page "1"
  
Scenario: Verify invalid option on the group menu page
    Given User "camfed_user" is enrolled with following groups:
     |name         |
     |History      |
     |Physics      |
     |Geography    |
  	Given User chooses the option "Groups"
  	Then User should see the ordered groups list on page "1"
    When User chooses the group "History"
    Then User should see the group menu page
    When User sends an invalid option "9"
    Then User returns with error "invalid_option"
    And User replies to go back to previous menu
    Then User should see the ordered groups list on page "1"
    
Scenario: Verify invalid option on the group list page
  Given User "camfed_user" is enrolled with following groups:
         |name         |
         |History      |
         |Physics      |
         |Geography    |
  Given User chooses the option "Groups"
  Then User should see the ordered groups list on page "1"
  When User sends an invalid option "9"
  Then User returns with error "invalid_option"
  
@manual
Scenario: Verify edited groups are reflected on ussd app after re-login
   Given User "camfed_user" is enrolled with following groups:
   |name         |
   |History      |
   |Physics      |
   |Geography    |
   And User chooses the option "Groups"
   Then User should see the ordered groups list on page "1"
   Given the following groups are deleted:
   |name|
   |History      |
   Given I make a new USSD login request
 	 When User "camfed_user" logs into USSD with correct credentials
 	 Then User should see the USSD home page
 	 Given User chooses the option "Groups"
   Then User should see the ordered groups list on page "1"
   

