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
@wip
Scenario: Verify admin can add a user with country and district
  When User is on the Sign In page
  And User "camfed_account_admin" logs into Canvas with her credentials
  When User visits the account page
  Then User chooses to add a new user to the account
  Then User should see the add user dialog
  Then User enters the name for user "Norah Jones"
  Then User enters the email for user "norah@jones.com"
  Then User enters the login for user "njones"
  Then User chooses the country for user "Zimbabwe"
  Then User chooses the district for user "Binga"
  Then User confirms the creation
  Then User should see success message for creating user
  Then User navigates to page of "Norah Jones"
  Then User has name set to "Norah Jones"
  Then User has location set to "Zimbabwe | Binga"
  Then User logs out
