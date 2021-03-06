@javascript
Feature:

	In order to know about the social surroundings
	As a User
	I want to be able to view pending connections requests on my mobile device

Background:
    Given the following users exists in canvas:
      |USER            |COUNTRY|DISTRICT|
      |requesting_user1|||
      |requesting_user2|||
      |requesting_user3|||
      |requesting_user4|||
      |requesting_user5|Ghana  |Kumbungu|
    And User "camfed_user" has pending connection requests from:
      |USER|
      |requesting_user1|
      |requesting_user2|
      |requesting_user3|
      |requesting_user4|
      |requesting_user5|
    And I make a new USSD login request
    When User "camfed_user" logs into USSD with correct credentials
    Then User should see the USSD home page
    Given User chooses the option "Connections"
    Then User should see the connections menu with 0 connections and 5 requests

Scenario: View connections requests
    When User chooses option "2"
    Then User should see ordered pending requests on page "1"
    When User chooses the "Next" option
    Then User should see ordered pending requests on page "2"

Scenario: Accept and reject connection
  When User chooses option "2"
  Then User should see ordered pending requests on page "1"
  When User chooses option "1"
  Then User should see connection response options
  When User chooses "Accept" option
  Then User should see the notice "connection_request_accepted" with "requesting_user5"
  Then User should see ordered pending requests on page "1"
  When User chooses option "1"
  Then User should see connection response options
  When User chooses "Reject" option
  Then User should see the notice "connection_request_rejected" with "requesting_user4"
  Then User should see ordered pending requests on page "1"
  And User chooses option "0"
  Then User should see the connections menu with 1 connections and 3 requests





  @integration
  Scenario: Verify if accepting a user from USSD app reflects on canvas
  When User chooses option "2"
  Then User should see ordered pending requests on page "1"
  When User chooses option "1"
  Then User should see connection response options
  When User chooses "Accept" option
  Then User should see the notice "connection_request_accepted" with "requesting_user5"
  When User is on the Sign In page
  When User "camfed_user" logs into Canvas with her credentials
  When User navigates to "My Connections" page
  Then User can see "1" connections available
  When User navigates to "Connection Requests"
  And User can see "4" pending requests
  Then User logs out

@integration  
  Scenario: Verify if rejecting a user from USSD app reflects on canvas
  When User chooses option "2"
  Then User should see ordered pending requests on page "1"
  When User chooses option "1"
  Then User should see connection response options
  When User chooses "Reject" option
  Then User should see the notice "connection_request_rejected" with "requesting_user5"
  When User is on the Sign In page
  When User "camfed_user" logs into Canvas with her credentials
  When User navigates to "My Connections" page
  Then User can see "0" connections available
  When User navigates to "Connection Requests"
  And User can see "4" pending requests
  Then User logs out
  
Scenario: Verify back from connection requests page
  When User chooses option "2"
  Then User should see ordered pending requests on page "1"
  And User replies to go back to previous menu
  And User replies to go back to previous menu
  Then User should see the USSD home page
  

Scenario: Verify invalid option from connection requests page
  When User chooses option "2"
  Then User should see ordered pending requests on page "1"
  And User sends an invalid option "9"
  Then User returns with error "invalid_option"
  
  
Scenario: Verify invalid option from connection request action page
  When User chooses option "2"
  Then User should see ordered pending requests on page "1"
  When User chooses option "1"
  Then User should see connection response options
  And User sends an invalid option "9"
  Then User returns with error "invalid_option"
  
  
Scenario: Verify back from connection request action page  
When User chooses option "2"
 Then User should see ordered pending requests on page "1"
 When User chooses option "1"
 Then User should see connection response options
 And User replies to go back to previous menu
 Then User should see ordered pending requests on page "1"
 
 
Scenario: Verify invalid option after user rejects a connection
  When User chooses option "2"
  Then User should see ordered pending requests on page "1"
  When User chooses option "1"
  Then User should see connection response options
  When User chooses "Reject" option
  Then User should see the notice "connection_request_rejected" with "requesting_user5"
  And User sends an invalid option "9"
  Then User returns with error "invalid_option"
  When User chooses the "Previous" option
  Then User should see ordered pending requests on page "1"
  
  
Scenario: Verify invalid option after user accepts a connection
   When User chooses option "2"
   Then User should see ordered pending requests on page "1"
   When User chooses option "1"
   Then User should see connection response options
   When User chooses "Accept" option
   Then User should see the notice "connection_request_accepted" with "requesting_user5"
   And User sends an invalid option "9"
   Then User returns with error "invalid_option"
   When User chooses the "Previous" option
   Then User should see ordered pending requests on page "1"

Scenario: Verify the profile information is displayed on connection details
  When User chooses option "2"
  Then User should see ordered pending requests on page "1"
  When User chooses option "1"
  Then User should see location of "requesting_user5" in connection profile

@wip
Scenario: Verify that accepting connection request reflects on web

@wip
Scenario: Verify that rejecting connection request reflects on web


  
  
  

    

