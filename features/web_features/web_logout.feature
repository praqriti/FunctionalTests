@javascript
Feature:

  In order to control the admin functionality
  As an admin
  I want to login to the system

Scenario: logout for the canvas network from CAS

When User is on the Sign In page
And User "camfed_student" logs into Canvas with her credentials
And "camfed_student" should see the Canvas home page
And User logs out
And User navigates to canvas home page
Then User is on the Sign In page


Scenario: logout for the social education network from CAS
 
  When User is on the Sign In page
  And User "camfed_student" logs into Canvas with her credentials
  And "camfed_student" should see the Canvas home page
  And User logs out
  And User navigates to search page
  Then User is on the Sign In page
  
Scenario: logout and login as another user succesfully

    Given User is on the Sign In page
    And User "camfed_student" logs into Canvas with her credentials
    And "camfed_student" should see the Canvas home page
    And User logs out
    When the following users exists in canvas:
             |USER|
             |camfed_teacher|
    And User "camfed_teacher" logs into Canvas with her credentials
    Then "camfed_teacher" should see the Canvas home page  