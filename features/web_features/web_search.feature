Feature:

  In order find other users
  As an a
  I want to be able to search users
  
  Background:
  Given the following user exists in canvas:
  |LOGIN_ID|PASSWORD|
  |web_test_user|web_test_user|
  |search user 1|search user 1|
  |search user 2|search user 2|
  

  When I am on the Sign In page
  And I enter my login_id "web_test_user" and password "web_test_user"
  And "web_test_user" should be successfully logged into canvas
  And User clicks on "search user" under connections tab
  
  @wip 
  Scenario: Verify User can make a blank search   
  When User searches for "" and clicks search
  Then User should see the users:
  |LOGIN_ID|
  |search_user_1|
  |search_user_2|
  
  @wip
  Scenario: Verify User can make a successful search 
   When User searches for "search" and clicks search
   Then User should see the users:
   |LOGIN_ID|
   |search user 1|
   |search user 2|
   
   @wip
   Scenario: Verify User can make a successful search 
    Given User searches for "user 1" and clicks search
    When User should see the users:
    |LOGIN_ID|
    |search user 1|
    |search user 2|
    Then User must be able to navigate to the wall of  "search user 1"
    
    
    
    
    
  
  
  