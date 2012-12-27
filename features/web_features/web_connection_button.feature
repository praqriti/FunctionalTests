@javascript
Feature:

  In order to view my comments
  As a user
  I want to access my wall

  Background:
  When User is on the Sign In page
  And  User "camfed_user" logs into Canvas with her credentials
  And "camfed_user" has his status set to "status message"

@wip @394
Scenario: View the correct status of connection button on user wall
Given the following users exists in canvas:
   |USER|
   |camfed_friend_user|
   |camfed_non_friend|
   |camfed_pending_request_user|
   |camfed_awaiting_response_user|
   And "camfed_user" is connected to "camfed_friend_user"
   Then User can navigate and view my wall without a connection button
   When User "camfed_user" has pending connection requests from:
   |USER|
   |camfed_pending_request_user|
   When User "camfed_awaiting_response_user" has pending connection requests from:
   |USER|
   |camfed_user|
   Then User can view the wall of "camfed_non_friend" with button "Add as a connection"
   Then User can view the wall of "camfed_friend_user" without button "Add as a connection"
   Then User can view the wall of "camfed_pending_request_user" with button "Awaiting Response"
   Then User can view the wall of "camfed_awaiting_response_user" with button "Awaiting Your Response"
   And User logs out

@wip @394
Scenario: View the correct status of connection button on user wall
Given the following users exists in canvas:
  |USER|
  |camfed_user_1|
  |camfed_user_2|
  Then User can view the basic user information of "camfed_user_1"
  And "camfed_user" is connected to "camfed_user_2"
  Then User can view the basic user information of "camfed_user_2"
  And User logs out
   
@wip @394
Scenario: View the pending connection button changes correctly on user wall
Given the following users exists in canvas:
   |USER|
   |camfed_test_user|
   |camfed_pending_request_user|
   Then User can view the wall of "camfed_non_friend" with button "Add as a connection"
   And "camfed_user" is connected to "camfed_test_user"
   Then User can view the wall of "camfed_friend_user" without button "Add as a connection"
   Then User can navigate and view my wall without a connection button
   When User "camfed_user" has pending connection requests from:
   |USER|
   |camfed_pending_request_user|
   Then User can view the wall of "camfed_pending_request_user" with button "Awaiting Your Response"
   When User navigates to "Connection Requests"
   Then User can "accept" the connection request from "camfed_pending_request_user"
   Then User can view the wall of "camfed_pending_request_user" without button "Add as a connection"
   And User logs out
   
@wip @394
Scenario: View the pending connection button changes correctly on user wall
Given the following users exists in canvas:
  |USER|
  |camfed_test_user|
  |camfed_pending_request_user|
  Then User can view the wall of "camfed_non_friend" with button "Add as a connection"
  And "camfed_user" is connected to "camfed_test_user"
  Then User can view the wall of "camfed_friend_user" without button "Add as a connection"
  Then User can navigate and view my wall without a connection button
  When User "camfed_pending_request_user" has pending connection requests from:
  |USER|
  |camfed_user|
  Then User can view the wall of "camfed_pending_request_user" with button "Awaiting Response"
  When User navigates to "Connection Requests"
  Then User can "accept" the connection request from "camfed_pending_request_user"
  Then User can view the wall of "camfed_pending_request_user" without button "Add as a connection"
  And User logs out