@javascript
Feature:

  In order to view my comments
  As a user
  I want to access my wall

  Background:
  When User is on the Sign In page
  And  User "camfed_user" logs into Canvas with her credentials
  And "camfed_user" has his status set to "status message"

  Scenario: Verify the elements on My Wall
  Given User clicks on My Wall
  Then User lands on My Wall and can view all the elements
  And User can view her latest status message "status message"
	And User can view the timestamp on the status
  And User logs out

@stage
  Scenario: Verify user can comment on her status message
  Given User clicks on My Wall
  Then User lands on My Wall and can view all the elements
  And User can view her latest status message "status message"
  And User comments "Good Status" on her status message
  Then the comments are visible on My Wall
  |COMMENT|
  |Good Status|
  And User can view her name "camfed_user" on the comment
	And User can view the timestamp on the comment
  And User logs out
  
  Scenario: Verify user cannot enter blank comment
  Given User clicks on My Wall
  Then User lands on My Wall and can view all the elements
  And User can view her latest status message "status message"
  And User cannot enter blank comment on the status
  And User logs out

  #need to figure out a way to fix this
  @wip
  Scenario: Verify user can comment multiple times on her status message
  Given User clicks on My Wall
  Then User lands on My Wall and can view all the elements
  And User can view her latest status message "status message"
  And User comments "Hello" on her status message
  And User comments "Good" on her status message
  Then the comments are visible on My Wall
  |COMMENT|
  |Hello  |
  |Good   |
  And User logs out

  @manual
  Scenario: Verify user cannot enter a comment greater than 1024 characters
  Given User clicks on My Wall
  Then User lands on My Wall and can view all the elements
  And User comments on her status message:
  """
  thisisacommentwhichisgreaterthan1024characterswhichshouldnotbeallowed
  """
  Then the comment visible is:
  """
  thisisacommentwhichisgreaterthan1024characters
  """
  And User logs out
  
  @manual
  Scenario: Verify user profile is displayed on both public and private user wall
  
  @manual @bug
  Scenario: Verify edited picture is reflected on both wall and search results
    
    
      
   
