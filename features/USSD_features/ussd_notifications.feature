@javascript
Feature:

	In order to know about the social surroundings
	As a User
	I want to be able to view my notifications on my mobile device

Background:

	Given I make a new USSD login request
	When User "camfed_user" logs into USSD with correct credentials
	Then User should see the USSD home page

@stage
Scenario: Verify back from notifications page from ussd	
        	Given User chooses the option "Notifications"
        	And User should see the notifications menu with blank notifications
            And User replies to go back to previous menu
        	Then User should see the USSD home page


Scenario: Should see the notification list for a category with pagination
          Given User has "4" accepted connection requests
          Given User has "4" comment notifications
          Given User has "4" status notifications
          Given User has "4" new group announcement notifications
          Given User has "4" new assignments
           Given User chooses the option "Notifications"
           And User should see the notifications menu with "1 Announcement (4)"
           When User chooses the "Next" option
           And User should see the notifications menu with "2 Assignment Created (4)"
           When User chooses the "Next" option
           And User should see the notifications menu with "3 Comment Added (4)"
           When User chooses the "Next" option
           And User should see the notifications menu with "4 Connection Request Accepted (5)"
           When User chooses the "Next" option
           And User should see the notifications menu with "5 Status Updated (4)"
           Then User should see the "Previous" option
           When User chooses the "Next" option
           Then User returns with error "invalid_option"
           And User replies to go back to previous menu
          Then User should see the USSD home page


Scenario: Should be able to navigate within the notifications with pagination
          Given User has "3" accepted connection requests
          Given User chooses the option "Notifications"
          When User should see the notifications menu with "1 Connection Request Accepted (3)"
          Then User replies with option "1"
          Then User should see connection notifications on USSD:
            |REQUESTING_FRIEND    |ACCEPTING_FRIEND|
            |camfed_friend_3|camfed_user|
            |camfed_friend_2|camfed_user| 
            |camfed_friend_1|camfed_user| 
          Then User returns with error "invalid_option"
          And User replies to go back to previous menu
          Then User should see the notifications menu with "1 Connection Request Accepted (3)"

Scenario: Should be able to view notificications for course and group announcements
          Given User has "3" new course announcement notifications
          Given User has "3" new group announcement notifications
          Given User chooses the option "Notifications"
          And User should see the notifications menu with "1 Announcement (6)"
          When User chooses the "Next" option
          Then User returns with error "invalid_option"
          And User replies to go back to previous menu
          Then User should see the USSD home page


Scenario: View announcements notifications with truncation on group
          Given Group "History" has "2" new announcements made by "camfed_user":
            |ANNOUNCEMENTS|
            |1.My father trained to be a fighter pilot in South Africa|
            |2.My father trained to be a fighter pilot in Asia|
            
          Given Course "History" has "2" new announcements made by "camfed_user":
            |ANNOUNCEMENTS|
            |3.My father trained to be a fighter pilot in Asia|
            |4.My father trained to be a fighter pilot in South Africa|
           
          Given User chooses the option "Notifications"
          And User should see the notifications menu with "1 Announcement (4)"
          Then User replies with option "1" 
          Then User should see announcement notification "4.My father trained to be a fighter pilot in South Africa" made by "camfed_user"
          When User chooses the "Next" option
          Then User should see announcement notification "3.My father trained to be a fighter pilot in Asia" made by "camfed_user"
          When User chooses the "Next" option
          Then User should see announcement notification "2.My father trained to be a fighter pilot in Asia" made by "camfed_user"
          When User chooses the "Next" option
          Then User should see announcement notification "1.My father trained to be a fighter pilot in South Africa" made by "camfed_user"
          When User chooses the "Next" option
          Then User returns with error "invalid_option"
          And User replies to go back to previous menu
          Then User should see the notifications menu with "1 Announcement (4)"

 
  @integration
    Scenario: Verify if comment notification is visible to the user on both web and ussd 
      Given the following users exists in canvas:
         |USER|
         |camfed_friend|
      Given User "camfed_user" has comment notifications from "camfed_friend": 
         |COMMENTS|
         |comment 1 from camfed_friend|
         |comment 2 from camfed_friend|
         |comment 3 from camfed_friend|
      Given User chooses the option "Notifications"
      When User should see the notifications menu with "1 Comment Added (3)"
      Then User replies with option "1"
      Then User should see comment notifications:
          |COMMENTED_BY |COMMENTED_TO|
          |camfed_friend|camfed_user|
          |camfed_friend|camfed_user|
          |camfed_friend|camfed_user|
      When User is on the Sign In page
      And User "camfed_user" logs into Canvas with her credentials
      Then home page has the following comment notifications:
       |COMMENTED_BY|COMMENT|
       |camfed_friend|comment 3 from camfed_friend|
       |camfed_friend|comment 2 from camfed_friend|
       |camfed_friend|comment 1 from camfed_friend|
      Then User logs out




