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
        	When User replies "0" from notifications page to go back to home page
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
           Then User replies "0" to go back to home page
               

Scenario: Should be able to navigate within the notifications with pagination
          Given User has "3" accepted connection requests
          Given User chooses the option "Notifications"
          When User should see the notifications menu with "1 Connection Request Accepted (3)"
          Then User replies with option "1"
          And "camfed_user" should see connection notification for user "camfed_friend_3" with page_no "1"
          When User chooses the "Next" option
          And "camfed_user" should see connection notification for user "camfed_friend_2" with page_no "2"
          When User chooses the "Next" option
          And "camfed_user" should see connection notification for user "camfed_friend_1" with page_no "3"
          When User chooses the "Next" option
          Then User returns with error "invalid_option"
          Then User replies "0" to go back to home page
          
Scenario: Should be able to view notificications for course and group announcements
          Given User has "3" new course announcement notifications
          Given User has "3" new group announcement notifications
          Given User chooses the option "Notifications"
          And User should see the notifications menu with "1 Announcement (6)"
          When User chooses the "Next" option
          Then User returns with error "invalid_option"
          Then User replies "0" to go back to home page


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
          Then User replies "0" to go back to home page




