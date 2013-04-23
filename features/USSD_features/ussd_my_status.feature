@javascript
Feature:

	In order utilise the social aspect of canvas
	As a user
	I want to view details about my status using my mobile device
  
Background:
  Given the following users exists in canvas:
    |USER|
    |camfed_friend_1|
    |camfed_friend_2|
  Given I make a new USSD login request
  When User "camfed_user" logs into USSD with correct credentials
  Then User should see the USSD home page

Scenario: View the my status menu options from USSD
  Given User chooses the option to view "my status"
  Then User should see the USSD my status page

Scenario: Update and view new status update from USSD
  Given "camfed_user" has his status set to "status_update_for_comment"
  And User chooses the option to view "my status"
  Then User should see the current status of "camfed_user"
  And User should see the USSD my status page

Scenario: View comments on status from USSD
  Given User "camfed_user" has the following comment notifications:
    |COMMENTED_BY   |COMMENT|
    |camfed_friend_1|first comment|
    |camfed_friend_2|second comment|
  And User chooses the option to view "my status"
  Then User should see the current status of "camfed_user"
  And User should see the view comments menu option with "2" comments
  When User replies with "3"
  Then User should see comment "second comment" made by "camfed_friend_2"
  Then User should not see "Previous"
  When User chooses the "Next" option
  Then User should see comment "first comment" made by "camfed_friend_1"
  Then User should not see "Next"
  Then User should see "Previous"

Scenario: User tries to view comments when there are no comments
  Given "camfed_user" has his status set to "status_update_for_comment"
  Given User chooses the option to view "my status"
  And User has no comments on his status
  When User chooses the option to view "comments on the status"
  Then User should see no comments message

