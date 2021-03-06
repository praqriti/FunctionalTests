@javascript
Feature:

  In order to control the admin functionality
  As an admin
  I want to login to the system

Scenario: logout for the canvas network from CAS

When User is on the Sign In page
And User "camfed_user" logs into Canvas with her credentials
And User logs out
And User navigates to canvas home page
Then User is on the Sign In page


Scenario: logout for the social education network from CAS
 
  When User is on the Sign In page
  And User "camfed_user" logs into Canvas with her credentials
  And User logs out
  Then User is on the Sign In page

@stage  
Scenario: logout and login as another user succesfully
    Given the following users exists in canvas:
         |USER|
         |camfed_teacher|
    And User is on the Sign In page
    And User "camfed_user" logs into Canvas with her credentials
    And User logs out and logs into canvas as "camfed_teacher"
    Then User logs out
    
@stage
Scenario: access sen social before loggin in
    Given the following users exists in canvas:
         |USER|
         |camfed_teacher|
    And User is on the Sign In page
    And User "camfed_user" logs into Canvas with her credentials
  	Then User clicks on My Wall
    And User logs out and logs into canvas as "camfed_teacher"
    Then User clicks on My Wall    
    Then User logs out

