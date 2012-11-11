@javascript
Feature:

  In order to control the admin functionality
  As an admin
  I want to login to the system
  
  Scenario: login to canvas as a user using CAS

  When User is on the Sign In page
  And User "camfed_user" logs into Canvas with her credentials
  Then "camfed_user" should see the Canvas home page
  Then User logs out
