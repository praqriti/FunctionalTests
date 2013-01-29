@javascript
Feature:

  In order to view my comments
  As a user
  I want to access my wall

  Background:
  When User is on the Sign In page
  And  User "camfed_user" logs into Canvas with her credentials

Scenario: View the correct status of connection button on user wall
Given the following users exists in canvas:
   |USER|
   |camfed_friend_user|
   |camfed_non_friend|
   |camfed_pending_request_user|
   |camfed_awaiting_response_user|
   And "camfed_user" is connected to "camfed_friend_user"
   Then User can navigate and view "his" wall without a connection button
   When User "camfed_user" has pending connection requests from:
   |USER|
   |camfed_pending_request_user|
   When User "camfed_awaiting_response_user" has pending connection requests from:
   |USER|
   |camfed_user|
   Then User can navigate and view "camfed_non_friend" wall with button "Add Connection"
   Then User can navigate and view "camfed_friend_user" wall without a connection button
   Then User can navigate and view "camfed_pending_request_user" wall with button "Awaiting Your Response"
   Then User can navigate and view "camfed_awaiting_response_user" wall with button "Awaiting Response"
   And User logs out
   
Scenario: View the Awaiting your response button updates correctly on user wall
Given the following users exists in canvas:
   |USER|
   |camfed_pending_request_user|
   When User "camfed_user" has pending connection requests from:
   |USER|
   |camfed_pending_request_user|
   Then User can navigate and view "camfed_pending_request_user" wall with button "Awaiting Your Response"
   When User navigates to "Connection Requests"
   Then User can "accept" the connection request from "camfed_pending_request_user"
   Then User can navigate and view "camfed_pending_request_user" wall without a connection button
   And User logs out
   
Scenario: Verify the Awaiting response button updates correctly on user wall
Given the following users exists in canvas:
  |USER|
  |camfed_pending_request_user|
  When User "camfed_pending_request_user" has pending connection requests from:
  |USER|
  |camfed_user|
  Then User can navigate and view "camfed_pending_request_user" wall with button "Awaiting Response"
  And User logs out
  When User is on the Sign In page
  And  User "camfed_pending_request_user" logs into Canvas with her credentials
  When User navigates to "Connection Requests"
  Then User can "accept" the connection request from "camfed_user"
  And User logs out
  When User is on the Sign In page
  And User "camfed_user" logs into Canvas with her credentials
  Then User can navigate and view "camfed_pending_request_user" wall without a connection button
  And User logs out
  
Scenario: Verify the Add Connection button updates correctly after "disconnect"
Given the following users exists in canvas:
   |USER|
   |camfed_friend_user|
   Then User can navigate and view "camfed_friend_user" wall with button "Add Connection"
   And "camfed_user" is connected to "camfed_friend_user"
   When User navigates to "My Connections" page
   And User can "disconnect" his connection "camfed_friend_user"
   And User confirms the disconnection "camfed_friend_user"
   Then User can navigate and view "camfed_friend_user" wall with button "Add Connection"
   And User logs out
   
Scenario: Verify the Add Connection button updates correctly after "Reject"
Given the following users exists in canvas:
  |USER|
  |camfed_friend_user|
  When User "camfed_user" has pending connection requests from:
  |USER|
  |camfed_friend_user|
  Then User can navigate and view "camfed_friend_user" wall with button "Awaiting Your Response"
  When User navigates to "Connection Requests"
  Then User can "reject" the connection request from "camfed_friend_user"
  Then User can navigate and view "camfed_friend_user" wall with button "Add Connection"
  And User logs out
  
Scenario: Verify that connection is added by using add connection button
Given the following users exists in canvas:
  |USER|
  |camfed_friend_user|
  Then User can navigate and view "camfed_friend_user" wall with button "Add Connection"
  When User clicks on "Add Connection" button
  Then User can navigate and view "camfed_friend_user" wall with button "Awaiting Response"
  And User logs out
  When User is on the Sign In page
  And  User "camfed_friend_user" logs into Canvas with her credentials
  And User navigates to "Connection Requests"
  Then User can see the pending connection requests sent from:
  |USER|
  |camfed_user|
  And User logs out

@wip 
Scenario: Verify the add connection action updates correctly on USSD app
 

  
  