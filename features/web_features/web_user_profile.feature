@javascript
Feature:

  In order to manage profile
  As a User
  I want to be able to use the manage user settings feature

Background:
  Given the following users exists in canvas:
  |USER            |COUNTRY|DISTRICT|
  |camfed_test_user|Ghana  |Kumbungu|

Scenario: Verify user can view his location on settings page
  When User is on the Sign In page
  And User "camfed_test_user" logs into Canvas with her credentials
  When User visits the settings page
  Then User should see "Ghana" and "Kumbungu" as the location in its profile
  Then User logs out

Scenario: Verify user can edit his location on settings page
  When User is on the Sign In page
  And User "camfed_test_user" logs into Canvas with her credentials
  When User visits the settings page
  Then User should see "Ghana" and "Kumbungu" as the location in its profile
  When user edits his settings
  And user updates his location to "Malawi" and "Mangochi"
  Then user updates the settings
  Then User should see "Malawi" and "Mangochi" as the location in its profile
  Then User logs out
