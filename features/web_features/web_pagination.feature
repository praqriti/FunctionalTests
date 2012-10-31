@javascript
Feature:

	In order to use canvas 
	As an user
	I am on the home page of canvas
	
Background:

  Given the following users exists in canvas:
    |USER|
    |camfed_student|
  Given User "camfed_student" has pending connection requests from "4" users
  When User is on the Sign In page
  And User "camfed_student" logs into Canvas with her credentials
  When "camfed_student" should see the Canvas home page

Scenario: Verify if a logged in user can view the correct number of connections per page   
    When User navigates to "Connection Requests"
    Then User can view "2" connection requests on "Connections Requests" page
    And User clicks on "show more" on "Connections Requests" page
    And User can view "4" connection requests on "Connections Requests" page
    And User logs out    
    
  
Scenario: Verify if a logged in user can reject connection request after pagination
      When User navigates to "Connection Requests"
      And User clicks on "show more" on "Connections Requests" page
      And User rejects a connection request from page "2"
      And User can see the "3" pending requests
      Then User navigates to "My Connections" page
      Then User can see the "0" connections available
      And User logs out    
      
Scenario: Verify if a logged in user can accept connection request after pagination
      When User navigates to "Connection Requests"
      And User clicks on "show more" on "Connections Requests" page
      And User accepts a connection request from page "2"
      And User can see the "3" pending requests
      Then User navigates to "My Connections" page
      Then User can see the "1" connections available
      And User logs out

Scenario: Verify if a logged in user can view correct number of connected users per page and disconnect a user after pagination
      When User navigates to "Connection Requests"
      And User clicks on "show more" on "Connections Requests" page
      And User accepts "4" connection requests
      And User navigates to "My Connections" page
      Then User can see the "4" connections available
      Then User can view "2" connections on "My Connections" page
      And User clicks on "show more" on "My Connections" page
      And User can view "4" connections on "My Connections" page
      And User disconnects a connection
      And User navigates to "My Connections" page
      And User clicks on "show more" on "My Connections" page
      Then User can view "3" connections on "My Connections" page
      And User logs out 

