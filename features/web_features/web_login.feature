@javascript
Feature:

  In order to control the admin functionality
  As an admin
  I want to login to the system
  
  Scenario: login to canvas as a user using CAS
  Given the following user exists in canvas:
  |USER|
  |rocket|

  When I am on the Sign In page
  And User "rocket" logs into Canvas with her credentials
  Then "rocket" should see the Canvas home page
  Then User logs out
  