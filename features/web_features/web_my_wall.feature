@wip
Feature:

  In order to view my comments
  As a user
  I want to access my wall
  
  Background:
   Given the following user exists in canvas:
    |LOGIN_ID|PASSWORD|
    |canvas_test_user|password|

  When I am on the Sign In page
  And I enter my login_id "canvas_test_user" and password "password"
  And "canvas_test_user" should be successfully logged into canvas
  When User "updates" the status message as "status message"
  Then User status "status message" is updated successfully
  
  Scenario: Verify the elements on My Wall
  Given User clicks on My Wall
  Then User lands on My Wall and can view all the elements
  And User can view her latest status message "status message"
  And User can view the comments attached to the status message
  And User can view the information of the user who has commented on the status message
  
   Scenario: Verify user can comment on her status message
   Given User clicks on My Wall
   Then User lands on My Wall and can view all the elements
   And User can view her latest status message "status message"
   And User comments "abc" on her status message 
   Then the comment is visible on My Wall 
   
    Scenario: Verify user cannot enter blank comment
    Given User clicks on My Wall
    Then User lands on My Wall and can view all the elements
    And User can view her latest status message
    And User cannot enter blank comment on the status
    
    Scenario: Verify user cannot enter a comment greater than 1024 characters
    Given User clicks on My Wall
    Then User lands on My Wall and can view all the elements
    And User comments on her status message:
    """
    askskdfjksdljflsjgkfdhskfhdksjjfdhfkdsjffjjfjfhjfhghgjgkgg
    """
    Then the comment visible is:
    """
    askskdfjksdljflsjgkfdhskfhdksjjfdhfkdsjffjjfjfhjfhghgjgkgg
    """
    
      Scenario: Verify user can comment on her status message
      Given User clicks on My Wall
      Then User lands on My Wall and can view all the elements
      And User comments "abc" on her status message 
      And User comments "def" on her status message
      Then the comment "" is visible on top of My Wall 
  
   
    
    
      
   
