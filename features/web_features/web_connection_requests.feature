Feature:

	In order to use canvas 
	As an user
	I am on the home page of canvas

Background:
Given the following users exists in canvas:
      |USER|
      |requesting_user|
@wip
Scenario: Verify if a logged in user can view his connection requests
	Given User "camfed_student" has pending connection requests from:
	|USER|
	|requesting_user|
	When User is on the Sign In page
  And User "camfed_student" logs into Canvas with her credentials
  Then "camfed_student" should see the Canvas home page
	When User navigates to "Connection Requests"
	Then User can see the pending connection requests sent from:
	|USER|
	|requesting_user|
	Then User logs out
  
  @leave_the_window_open
  Scenario: Verify if a logged in user can accept his connection requests
    Given User "camfed_student" has pending connection requests from:
          |USER|
          |requesting_user|
          When User is on the Sign In page
          And User "camfed_student" logs into Canvas with her credentials
          Then "camfed_student" should see the Canvas home page
          When User navigates to "Connection Requests"
          And User can see the pending connection requests sent from:
          |USER|
          |requesting_user|
    Then User can "accept" the connection request from "requesting_user"
    When User navigates to my connections page
    And User can see "requesting_user" on my connections page

@wip 
Scenario: Verify if a logged in user can view his connection requests
Given User "camfed_student" has pending connection requests from:
|USER|
|requesting_user|
When User is on the Sign In page
And User "camfed_student" logs into Canvas with her credentials
When User navigates to "Connection Requests"
Then User can see the pending connection requests sent from:
|USER|
|requesting_user|
And User can view the connection requests in alphabetical order
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



