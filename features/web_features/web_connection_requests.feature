@javascript
Feature:

	In order to use canvas 
	As an user
	I am on the home page of canvas

Background:

Given the following users exists in canvas:
      |USER|
      |requesting_user|

@wip
Scenario: Verify if a logged in user can accept his connection requests
    When User "camfed_student" has pending connection requests from:
          |USER|
          |requesting_user|
    When User is on the Sign In page
    When User "camfed_student" logs into Canvas with her credentials
    When "camfed_student" should see the Canvas home page
    When User navigates to "Connection Requests"
    When User can see the pending connection requests sent from:
          |USER|
          |requesting_user|
    Then User can "accept" the connection request from "requesting_user"
    Then User navigates to "My Connections" page
    And User can see "requesting_user" on my connections page
    Then User logs out

@wip  	
Scenario: Verify if a logged in user can reject his connection requests
  When User "camfed_student" has pending connection requests from:
             |USER|
             |requesting_user|
  When User is on the Sign In page
  When User "camfed_student" logs into Canvas with her credentials
  When "camfed_student" should see the Canvas home page
  When User navigates to "Connection Requests"
  When User can see the pending connection requests sent from:
             |USER|
             |requesting_user|
  Then User can "reject" the connection request from "requesting_user"
  And User can see the "0" pending requests
  Then User navigates to "My Connections" page
  And User cannot see "requesting_user" on my connections page
  Then User logs out
	
@wip	
Scenario: Verify if a logged in user can disconnect his connections
When User "camfed_student" is connected to:
|USER|
|requesting_user|
Then User can see the "1" connections available
When User navigates to "My Connections" page
And User can "disconnect" his connection "requesting_user"
Then User can see the "0" connections available
Then User logs out

@wip
Scenario: Verify if a logged in user can view connection requests with pagination

	Given User has pending connection requests from "35" users
	When User hovers over connection menu and clicks on 'Connection Request'
	Then User can see "30" connection requests on the page
	And User clicks "next" to view more connection requests
	And User must see "5" connection requests
	And User must not see the "next" button
Then User logs out



