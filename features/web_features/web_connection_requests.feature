@wip
@javascript
Feature:

  In order to use canvas 
  As an user
  I am on the home page of canvas
  
Background:

Given I am on the Sign In page
Given User "camfed_student" logs into Canvas with her credentials
Given "camfed_student" should see the Canvas home page

@wip
Scenario: Verify User can view connection status on search page
Given the following users exists in canvas:
        |USER|
        |camfed_student_1|
        |camfed_student_2|
When User searches for "student" and clicks search
Then User should see "camfed_student_1" as an "unlinked" connection

Scenario: Verify if a logged in user can view his connection requests
Given User has pending connection requests from:
|USER|
|camfed_student_1|
|camfed_student_2|
When User hovers over connection menu and clicks on 'Connection Request'
Then User can see the pending connection requests sent from:
|USER|
|camfed_student_1|
|camfed_student_2|
And User can view the connection requests in alphabetical order
And the created users are deleted from canvas


Scenario: Verify if a logged in user can view connection requests with pagination
Given User has pending connection requests from "35" users
When User hovers over connection menu and clicks on 'Connection Request'
Then User can see "30" connection requests on the page
And User clicks "next" to view more connection requests
And User must see "5" connection requests
And User must not see the "next" button



