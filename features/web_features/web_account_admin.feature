@javascript
Feature:

  In order to manage accounts
  As an Admin
  I want to be able to use the account admin features

Background:
  Given the following users exists in canvas:
  |USER|
  |camfed_account_admin|
  |camfed_test_user|
  When User "camfed_account_admin" is assigned the role of account admin

@stage @bug
Scenario: Verify account admin can access all sen social features
  And "camfed_account_admin" has his status set to "single status message only"
  When User is on the Sign In page
   And User "camfed_account_admin" logs into Canvas with her credentials
   Then User status "single status message only" is updated successfully
   Then User can navigate and view the "public" wall of user "camfed_test_user"
   When User clicks on My Wall
   Then User logs out

Scenario: Verify admin can add a user with country and district
  When User is on the Sign In page
  And User "camfed_account_admin" logs into Canvas with her credentials
  When User visits the account page
  Then User chooses to add a new user to the account
  Then User should see the add user dialog
  Then admin creates the user:
  |NAME|COUNTRY|DISTRICT|
  |Norah Jones|Zimbabwe|Binga|
  Then User should see success message for creating user
  Then User navigates to page of "Norah Jones"
  Then User has name set for "Norah Jones"
  Then User has location set to "Binga, Zimbabwe"
  Then admin edits the user
  And sets location as "Ghana" and "Tolon"
  And admin updates the user
  Then User has location set to "Tolon, Ghana"
  Then User logs out
