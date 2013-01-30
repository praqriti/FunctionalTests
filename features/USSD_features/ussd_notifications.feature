Feature:

	In order to know about the social surroundings
	As a User
	I want to be able to view my notifications on my mobile device

Background:

	Given I make a new USSD login request
	When User "camfed_user" logs into USSD with correct credentials
	Then User should see the USSD home page

Scenario: View notifications menu with message when there are no message
	
	Given User chooses the option "Notifications"
	Then User should see the notifications menu with blank notifications

@stage
Scenario: Verify back from notifications page from ussd
	
	Given User chooses the option "Notifications"
	And User should see the notifications menu with blank notifications
	When User replies "0" from notifications page to go back to home page
	Then User should see the USSD home page

Scenario: Should see the aggregated notification category list with notification count for each category
  Given User "camfed_user" is enrolled with following courses:
    |COURSE     |ROLE    |STATUS|
    |History    |Student |active|

  Given the following users exists in canvas:
    |USER|
    |camfed_user_friend|

  And "camfed_user" is connected to "camfed_user_friend"
  And "camfed_user_friend" has his status set to "status message"

  Given I make a new USSD login request
  When User "camfed_user" logs into USSD with correct credentials
  Then User should see the USSD home page
  Given User chooses the option "Notifications"
  And User should see the notifications menu with "1 Connection Request Accepted (1)"


Scenario: Should see the notification list for a category with pagination
    # Given User "" has "" new course invitations
    #   Given User "" has "" accepted connection requests
    #   Given User "" has "" announcements on groups
    #   Given User "" has "" announcements on courses
    #   Given User "" has "" status update notifications
    #   Given User "" has "" status update notifications
    #   
    #   
    #   
    #   
    Given User "camfed_user" is enrolled with following courses:
      |COURSE     |ROLE    |STATUS|
      |History    |Student |active|

    Given the following users exists in canvas:
      |USER|
      |camfed_user_friend|
      |camfed_user_friend_new|

    And "camfed_user" is connected to "camfed_user_friend"
    And "camfed_user" is connected to "camfed_user_friend_new"

    Given I make a new USSD login request
    When User "camfed_user" logs into USSD with correct credentials
    Then User should see the USSD home page
    Given User chooses the option "Notifications"
    And User should see the notifications menu with "1 Connection Request Accepted (2)"
    Then User replies with option "1"
    And "camfed_user" should see connection notification for user "camfed_user_friend_new" with page_no "1"
    Then User replies with option "#"
    And "camfed_user" should see connection notification for user "camfed_user_friend" with page_no "2"


@manual
Scenario: Verify invalid optiont throws an appropriate error

