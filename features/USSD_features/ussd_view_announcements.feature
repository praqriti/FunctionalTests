@wip @javascript
Feature:

	In order to know the announcements I have enrolled for
	As a User
	I want to be able to view the list of my groups on my mobile device

Background:
Given User "camfed_user" is enrolled with following groups:
 |name         |
 |History      |
	Given I make a new USSD login request
	When User "camfed_user" logs into USSD with correct credentials
	Then User should see the USSD home page
	
Scenario: View announcements on group
Given User "camfed_user" makes "" new announcements for "History"
  Given Group "History" has "2" new announcements:
  |ANNOUNCEMENTS|
  |"Churchill’s determination to fight on at whatever cost made the difference."|
  |"My father trained to be a fighter pilot in South Africa"|
  And User chooses the option "Groups"
  Then User should see the ordered groups list on page "1"
  When User chooses the group "History"
  Then User should see "2" ordered announcements on page "1" with announcers name "camfed_user"
  Then User should not see the "Previous" and "Next" option 
	Then User should see the USSD home page
	

Scenario: Verify no announcements on groups  
	Given User chooses the option "Groups"
	Then User should see the ordered groups list on page "1"
	Then User chooses group "1"
	Then User should see the message "No announcement on group"
	When User replies "0" to go back to home page
	Then User should see the USSD home page
	
Scenario: View list of announcements on group with pagination
  Given Group "History" has "7" new announcements
  And User chooses the option "Groups"
  Then User should see the ordered groups list on page "1"
  When User chooses the group "History"
  Then User should see "3" ordered announcements on page "1"
  And User chooses the "Next" option
  Then User should see "3" ordered announcements on page "2"
	And User should see the "Next" and "Previous" option
	And User chooses the "Next" option
  Then User should see "1" ordered announcements on page "3"
  And User replies "0" to go back to home page
	Then User should see the USSD home page
	
Scenario: View that group announcement is truncated after 40 characters
  Given User "camfed_user" is enrolled with following groups:
     |name         |
     |History      |
  And Group "History" has a new announcement with more than 40 characters
  And User chooses the option "Groups"
  Then User should see the ordered groups list on page "1"
  When User chooses the group "History"
  Then User should see "1" ordered announcements on page "1"
  Then User should see only 40 characters in the announcement
  Then User chooses the "Previous" option
  Then User should see the ordered groups list on page "1"

Scenario: View that announcers name truncated after 15 characters
  Given User "camfed_user" is enrolled with following groups:
     |name         |
     |History      |
  And Group "History" has a new announcement with more than 15 characters
  And User chooses the option "Groups"
  Then User should see the ordered groups list on page "1"
  When User chooses the group "History"
  Then User should see "1" ordered announcements on page "1"
  Then User should see only 15 characters in the announcement
  Then User chooses the "Previous" option
  Then User should see the ordered groups list on page "1"
  
  
  