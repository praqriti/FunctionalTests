@javascript
Feature:

  In order to know my past statuses
  As a User
  I want to be able to view my status history

Background:

  When User is on the Sign In page
  And User "camfed_user" logs into Canvas with her credentials

Scenario: Verify appropriate message displayed if there is no history of status messages

	And "camfed_user" has his status set to "single status message only"
    Then User waits for "4" seconds
	Then User clicks on My Wall
	Then User clicks on Show previous status messages link
	Then User should see appropriate message
	Then User logs out

@stage @wip
Scenario: Verify user has 7 statuses with comments and can view previous 5 statuses with comments
  # Given "camfed_user" has a history of "3" status messages
  And "camfed_user" has his status set to "status message 1"
  And "camfed_user" has his status set to "status message 2"
  And "camfed_user" has his status set to "status message 3"
	Then User clicks on My Wall
	And User comments "Good Status" on her status message
  And "camfed_user" has his status set to "status message 4"
  Then User clicks on My Wall
  And User comments "Nice Status" on her status message
  And "camfed_user" has his status set to "status message 5"
	Then User clicks on My Wall
	And User comments "Wow! Incredible!" on her status message
	Then User navigates to canvas home page
  And "camfed_user" has his status set to "status message 6"
	And "camfed_user" has his status set to "status message 7"
  Then User clicks on My Wall
  Then User clicks on Show previous status messages link
  Then User should see previous "5" status messages
  |STATUS|
	|status message 6|
  |status message 5|
  |status message 4|
  |status message 3|
  |status message 2|
	And the comments are visible on My Wall in order of the date
  |COMMENT|
  |Wow! Incredible!|
  |Good Status|
	|Nice Status|
  Then User logs out

@wip
Scenario: Verify user has 3 statuses with comments and can view previous 2 statuses with comments

  And "camfed_user" has his status set to "status message 1"
  And "camfed_user" has his status set to "status message 2"
	Then User clicks on My Wall
	And User comments "Good Status" on her status message
	And User comments "Nice Status" on her status message
	Then User navigates to canvas home page
  And "camfed_user" has his status set to "status message 3"
	Then User clicks on My Wall
	And User comments "Wow! Env Setup is Fun!" on her status message
  Then User clicks on Show previous status messages link
  Then User should see previous "2" status messages
  |STATUS|
	|status message 2|
  |status message 1|
	And the comments are visible on My Wall in order of the date
  |COMMENT|
  |Wow! Env Setup is Fun!|
  |Good Status|
	|Nice Status|
  Then User logs out
