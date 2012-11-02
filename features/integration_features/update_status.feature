@javascript
Feature:

  In order to use multiple platforms in canvas
  As an user
  I should be able to see my changes from both mobile and web 
  
  Scenario: Status updated on web must be reflected on my mobile device
 
  When User is on the Sign In page
  And User "camfed_student" logs into Canvas with her credentials
  Then "camfed_student" should see the Canvas home page
  When User "updates" the status message as "status message"
  Then User status "status message" is updated successfully
 
  Given I make a new USSD login request
  When User "camfed_student" logs into USSD with her credentials
  Then "camfed_student" should see the USSD home page
  
  And User chooses the option to "update status"
  And User should see his previously updated message "status message"
  And User replies with new status message "new status message" 
  Then User should get a confirmation that the status was updated successfully
  
  Scenario: View status should be reflected on both canvas and ussd app

  Given I make a new USSD login request
  When User "camfed_student" logs into USSD with her credentials
  Then "camfed_student" should see the USSD home page

  And User chooses the option to "update status"
  And User replies with new status message "new status message" 
  Then User should get a confirmation that the status was updated successfully

	When User is on the Sign In page
  When User "camfed_student" logs into Canvas with her credentials
  Then "camfed_student" should see the Canvas home page
  And status message should be "new status message"
