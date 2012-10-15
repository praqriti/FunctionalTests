@javascript
Feature:

  In order to control the admin functionality
  As an admin
  I want to login to the system

Scenario: logout for the canvas network from CAS



When I am on the Sign In page
And User "camfed_student" logs into Canvas with her credentials
And "camfed_student" should see the Canvas home page
And User logs out
And User navigates to canvas home page
Then I am on the Sign In page


Scenario: logout for the social education network from CAS
 

  When I am on the Sign In page
  And User "camfed_student" logs into Canvas with her credentials
  And "camfed_student" should see the Canvas home page
  And User logs out
  And User navigates to search page
  Then I am on the Sign In page
  