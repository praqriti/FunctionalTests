@javascript
Feature:

  In order to manage canvas
  As a super admin
  I want to be able to use only the admin features

  

Scenario: Verify Super Admin cannot login using CAS
  Given Super Admin tries to login using CAS
  Then Super Admin must not be allowed to login
  
@manual @bug
Scenario: Verify account admin can access all sen social features if he has a cas login

   Given Super Admin logs into Canvas
   Then User must not see the wall
   And User must not see the status box
   And User must not be able able to see connections

@manual @bug
Scenario: Verify account admin is visible in search results if he has a cas login
  Given User is on the Sign In page
  And User "camfed_user" logs into Canvas with her credentials
  And "camfed_user" should see the Canvas home page
  When User searches for the Super Admin
  Then User should see the search error
