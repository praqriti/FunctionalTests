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
  And "camfed_account_admin" has his status set to "single status message only"
	
@stage @bug
Scenario: Verify account admin can access all sen social features

   When User is on the Sign In page
   And User "camfed_account_admin" logs into Canvas with her credentials
   Then User status "single status message only" is updated successfully
   Then User can navigate and view the "public" wall of user "camfed_test_user"
   When User clicks on My Wall
   Then User logs out
