@javascript
Feature:

	In order to know the announcements I have enrolled for
	As a User
	I want to be able to view the list of my groups on my mobile device

Background:
	Given I make a new USSD login request
	When User "camfed_user" logs into USSD with correct credentials
	Then User should see the USSD home page
	
Scenario: View announcements on group with truncation
  Given the following users exists in canvas:
   |USER|
   |camfed_user with_truncation|
  Given Group "History" has "1" new announcements made by "camfed_user with_truncation":
   |ANNOUNCEMENTS|
   |My father trained to be a fighter pilot in South Africa|
  Given I make a new USSD login request
  When User "camfed_user with_truncation" logs into USSD with correct credentials
  Then User should see the USSD home page
  Given User chooses the option "Groups"
  Then User should see the ordered groups list on page "1"
  When User chooses the group "History"
  Then User should see "View Announcements[1]"
  Then User chooses to view announcements
  Then User should see announcement "My father trained to be a fighter pilot in South Africa" made by "camfed_user with_truncation"
  Then User should not see "Previous" and "Next" option 
  When User replies "0" to go back to home page
	Then User should see the USSD home page
	

Scenario: verify that user should not see view announcement option and see no announcement message if no announcement on group
Given User "camfed_user" is enrolled with following groups:
  |name         |
  |History      |
	Given User chooses the option "Groups"
    When User chooses the group "History"
    Then User should see "No announcements on this group"
    Then User should not see "View Announcements"

Scenario: View list of announcements on group with pagination
    Given Group "History" has "5" new announcements made by "camfed_user":
    |ANNOUNCEMENTS|
    |Announcement 1|
    |Announcement 2|
    |Announcement 3|
    |Announcement 4|
    |Announcement 5| 
    And User chooses the option "Groups"
    When User chooses the group "History"
    Then User should see "View Announcements[5]"
    Then User chooses to view announcements
    Then User should see announcement "Announcement 5" made by "camfed_user"
    And User chooses the "Next" option
    Then User should see announcement "Announcement 4" made by "camfed_user"
    And User chooses the "Next" option
    Then User should see announcement "Announcement 3" made by "camfed_user"
    And User chooses the "Next" option
    Then User should see announcement "Announcement 2" made by "camfed_user"
    And User chooses the "Next" option
    Then User should see announcement "Announcement 1" made by "camfed_user"
    And User chooses the "Next" option
    Then User returns with error "invalid_option"
    Then User replies "0" to go back to home page
  
  