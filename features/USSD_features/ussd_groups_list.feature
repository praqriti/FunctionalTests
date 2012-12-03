@javascript
Feature:

	In order to know the Groups I have enrolled for
	As a User
	I want to be able to view the list of my groups on my mobile device

Background:

	Given I make a new USSD login request
	When User "camfed_user" logs into USSD with correct credentials
	Then User should see the USSD home page

@stage
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

#Scenario: User is not enrolled to any group
#	When User chooses the option "Courses"
#	Then User should see the message "no_group_attached"
#	And User should not see "Previous" and "Next" option
#
#Scenario: User is enrolled as an observer
#  Given User "camfed_user" is enrolled with following groups:
#   |GROUP     |ROLE     |STATUS|
#   |History    |Observer |active|
#   |Physics    |Observer |pending|
#   When User chooses the option "Courses"
#   Then User should see the message "no_group_attached"
#   And User should not see "Previous" and "Next" option
#
#@stage
#Scenario: Verify that error is given to the user when she enters an invalid option
#Given User "camfed_user" is enrolled with following groups:
# |GROUP     |ROLE    |STATUS|
# |History    |Student |pending|
# |Physics    |Teacher |active|
# |Geography  |Student |active|
# |Maths      |Teacher |active|
# |Biology    |Student |pending|
#	Given User chooses the option "Courses"
#	Given User sends an invalid option "5"
#  Then User returns to home page with error "invalid_option"
#
#Scenario: Verify groups are not repeated at multiples of four
#
#Given User "camfed_user" is enrolled with following groups:
# |GROUP     |ROLE    |STATUS|
# |History    |Student |pending|
# |Physics    |Teacher |active|
# |Geography  |Student |active|
# |Maths      |Teacher |active|
#	Given User chooses the option "Courses"
#	Then User replies "0" to go back to home page
#	And User chooses the option "Courses"
#	Then User should see the groups list
#	And User should not see "Previous" and "Next" option
#	When User chooses the "Next" option
#  Then User returns to home page with error "invalid_option"
#
#  @manual
#  Scenario: Verify that the order of groups in the list is correct with pagination
