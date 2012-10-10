Feature:

  In order to know about the social surroundings
  As a User
  I want to be able to view my notifications on my mobile device

Background:
Given the following user exists in canvas:
 |USER|
 |rocket|

 Given I make a new USSD login request
 When User "rocket" logs into USSD with her credentials
 Then "rocket" should see the USSD home page

Scenario: View notifications menu
Given User chooses the option "Notifications"
Then User should see the notifications menu

Scenario: Verify back from notifications page from ussd
Given User chooses the option "Notifications"
And User should see the notifications menu
When User replies "0" from notifications page to go back to home page
Then "rocket" should see the USSD home page

