@javascript
Feature:

  In order find other users
  As an a
  I want to be able to search users
  
  Background:   
   When User is on the Sign In page
   And User "camfed_user" logs into Canvas with her credentials
   Then "camfed_user" should see the Canvas home page
   And User navigates to search page
   
  Scenario: Verify User can make an incorrect search   
   When User searches for "!adadsindl!" and clicks search
   Then User should see the search error
   Then User logs out
   
  Scenario: Verify User can make a successful search 
   Given the following users exists in canvas:
          |USER|
          |camfed_new_student|
   When User searches for "camfed_new_student" and clicks search
   Then User should see the users
   |USER|
   |camfed_new_student|
   Then User logs out   

@stage
  Scenario: Verify User can navigate to users wall from search page
   Given the following users exists in canvas:
           |USER|
           |camfed_bio_student|
   When User searches for "camfed_bio_student" and clicks search
   Then User can navigate and view the wall of user "camfed_bio_student"
   Then User logs out   
   
  Scenario: Verify User can view unlinked user on search page
   Given the following users exists in canvas:
           |USER|
           |unlinked_connection_user|
   When User searches for "unlinked_connection_user" and clicks search
   Then User should see "unlinked_connection_user" as an "unlinked" connection
   Then User logs out
   

  Scenario: Verify User can add a connection and view it on search page
   Given the following users exists in canvas:
           |USER|
           |linked_connection_user|
   When User searches for "linked_connection_user" and clicks search
   And User adds the user "linked_connection_user" as a connection
   Then User should see "linked_connection_user" as an "request pending" connection
   Then User logs out
   
  Scenario: Verify that connection status does not appear for self on search
   When User searches for "camfed_user" and clicks search
   Then User should see "camfed_user" without any connection status
   Then User logs out
   
   
   @wip
   Scenario: Verify User can make a successful search with last name
   Given the following users exists in canvas:
           |USER|
           |camfed_user_1|
           |camfed_user_2|
    When User searches for "student" and clicks search
    Then User should see the users
    |USER|
    |camfed_user_1|
    |camfed_user_2|
    
  
  @wip 
  Scenario: Verify User cannot search for substring of first and last name
  Given User searches for "user 1" and clicks search
  When User should see the users:
  |LOGIN_ID|
  |search user 1|
  |search user 2|
  Then User must be able to navigate to the wall of  "search user 1"
  
    
    
    
    
  
  
  
