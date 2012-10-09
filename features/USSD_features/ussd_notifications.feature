Feature:

  In order to know about the social surroundings
  As a User
  I want to be able to view my notifications on my mobile device

Background:

Given the following user exists in canvas:
  |LOGIN_ID|PASSWORD|
  |camfed_ussd_test|password_one|

Given I make a new login request
When I enter the login credentials as "camfed_ussd_test" with password "password_one"
And I should see the home page for user "camfed_ussd_test"

Scenario: View notifications menu
Given User "camfed_ussd_test" chooses the option "Notifications"
Then User "camfed_ussd_test" should see the notifications menu

Scenario: Verify back from notifications page from ussd
Given User "camfed_ussd_test" chooses the option "Notifications"
Then User "camfed_ussd_test" should see the notifications menu
When User "camfed_ussd_test" replies "0" from notifications page to go back to home page
And I should see the home page for user "camfed_ussd_test"

