@wip
Feature:

  In order to view my comments
  As a user
  I want to access my wall

  Background:
  Given the following user exists in canvas:
  |LOGIN_ID|
  |rocket|

  When I am on the Sign In page
  And  User "rocket" logs into Canvas with her credentials
  And "rocket" should see the Canvas home page
  When User "updates" the status message as "status message"
  Then User status "status message" is updated successfully

  Scenario: Verify the elements on My Wall
  Given User clicks on My Wall
  Then User lands on My Wall and can view all the elements
  And User can view her latest status message "status message"
  And User logs out
#  And User can view the comments attached to the status message
#  And User can view the username of the user who has commented on the status message

  @leave_the_window_open
  Scenario: Verify user can comment on her status message
  Given User clicks on My Wall
  Then User lands on My Wall and can view all the elements
  And User can view her latest status message "status message"
  And User comments "abc" on her status message
  And User comments "def" on her status message
  Then the comment "def" is visible on My Wall
  And User logs out

  Scenario: Verify user cannot enter blank comment
  Given User clicks on My Wall
  Then User lands on My Wall and can view all the elements
  And User can view her latest status message "status message"
  And User cannot enter blank comment on the status
  And User logs out

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
  And User logs out
   
    
    
      
   
