@javascript
Feature:

  In order find other users
  As an a
  I want to be able to search users
  
  Background:
      
   
   When I am on the Sign In page
   And User "camfed_student" logs into Canvas with her credentials
   Then "camfed_student" should see the Canvas home page
   And User navigates to search page
   
   Scenario: Verify User can make an incorrect search   
   When User searches for "!adadsindl!" and clicks search
   Then User should see the search error
   Then User logs out
   
   Scenario: Verify User can make a successful search 
   Given the following users exists in canvas:
          |USER|
          |camfed_student_1|
          |camfed_student_2|
   When User searches for "student" and clicks search
   Then User should see the users
   |USER|
   |camfed_student_1|
   |camfed_student_2|
   Then the created users are deleted from canvas
   
   @wip
   Scenario: Verify User can make a successful search with last name
   Given the following users exists in canvas:
           |USER|
           |camfed_student_1|
           |camfed_student_2|
    When User searches for "student" and clicks search
    Then User should see the users
    |USER|
    |camfed_student_1|
    |camfed_student_2|
    Then the created users are deleted from canvas
  
  @wip 
  Scenario: Verify User cannot search for substring of first and last name
  Given User searches for "user 1" and clicks search
  When User should see the users:
  |LOGIN_ID|
  |search user 1|
  |search user 2|
  Then User must be able to navigate to the wall of  "search user 1"
  
    
    
    
    
  
  
  