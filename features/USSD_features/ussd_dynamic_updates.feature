@javascript
Feature:

	In order to know the latest of my social surroundings
	As a User
	I want to be able to view updated notifications on my mobile device

Background:

	Given I make a new USSD login request
	When User "camfed_user" logs into USSD with correct credentials
	Then User should see the USSD home page

Scenario: Verify dynamic update for updating status
          Given "camfed_user" has his status set to "status message"
          When User chooses the option to "update status"
        	Then User should see his previously updated message "status message"
        	When "camfed_user" has his status set to "new status message"
        	When User replies "0" to go back to home page
        	When User chooses the option to "update status"
        	Then User should see his previously updated message "new status message"

Scenario: Verify dynamic update for canvas notifications list
          Given User has "1" new group announcement notifications
          Given User chooses the option "Notifications"
          And User should see the notifications menu with "1 Announcement (1)"
          Given User has "1" new assignments
          Given User has "1" new group announcement notifications
          Then User replies "0" to go back to home page
          Given User chooses the option "Notifications"
          And User should see the notifications menu with "1 Announcement (2)"
          When User chooses the "Next" option
          And User should see the notifications menu with "2 Assignment Created (1)" 
          
Scenario: Verify dynamic update for sen social notifications list
          Given User has "1" accepted connection requests
          Given User chooses the option "Notifications"
          And User should see the notifications menu with "1 Connection Request Accepted (1)"
          
          Given User has "1" accepted connection requests
          Given User has "1" status notifications
          Then User replies "0" to go back to home page  
          Given User chooses the option "Notifications"        
          And User should see the notifications menu with "1 Connection Request Accepted (3)"
          When User chooses the "Next" option
          And User should see the notifications menu with "2 Status Updated (1)"
          
          Given User has "1" accepted connection requests
          Given User has "1" status notifications
          Given User has "1" comment notifications
          Then User replies "0" to go back to home page 
           Given User chooses the option "Notifications" 
          And User should see the notifications menu with "1 Comment Added (1)"
          When User chooses the "Next" option        
          And User should see the notifications menu with "2 Connection Request Accepted (6)"
          When User chooses the "Next" option
          And User should see the notifications menu with "3 Status Updated (2)"
          
          
Scenario: Verify dynamic update for my connections list
           Given User has "4" accepted connection requests
           Given User chooses the option "Connections"
           When User chooses option "1"
           Then User should see ordered connections list on page "1"
           When User chooses the "Next" option
           Then User returns with error "invalid_option"
           Given User has "1" accepted connection requests
           Then User replies "0" to go back to home page
           Given User chooses the option "Connections"
           When User chooses option "1"
           Then User should see ordered connections list on page "1"
           When User chooses the "Next" option
           Then User should see ordered connections list on page "2"
           When User chooses the "Next" option
           Then User returns with error "invalid_option"

Scenario: Verify dynamic update for connection request list
          Given User has "4" pending connection requests
          Given User chooses the option "Connections"
          When User chooses option "2"
          Then User should see ordered pending requests on page "1"
          When User chooses the "Next" option
          Then User returns with error "invalid_option"
          Given User has "1" pending connection requests
          Then User replies "0" to go back to home page
          Given User chooses the option "Connections"
          When User chooses option "2"
          Then User should see ordered pending requests on page "1"
          When User chooses the "Next" option
          Then User should see ordered pending requests on page "2"
          When User chooses the "Next" option
          Then User returns with error "invalid_option"
          
@wip
Scenario: Verify dynamic updates between pending and accepted connections

@wip
Scenario: Verify dynamic updates for group list,course list,view and make announcements, quiz list, quiz info, quiz score






