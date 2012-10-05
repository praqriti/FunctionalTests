@javascript
Feature:

  In order to use multiple platforms in canvas
  As an user
  I should be able to see my changes from both mobile and web 
  
  Scenario: Status updated on web must be reflected on my mobile device
  Given the following user exists in canvas:
   |LOGIN_ID|PASSWORD|
   |camfed_web_user|password|
  When I am on the Sign In page
  And I enter my login_id "camfed_web_user" and password "camfed_web_user"
  And "camfed_web_user" should be successfully logged into canvas
  When User "updates" the status message as "status message"
  Then User status "status message" is updated successfully
 
 # log-in to ussd and verify  
  Given I make a new login request
  When I enter the login credentials as "camfed_web_user" with password "password"
  And I should see the home page for user "camfed_web_user"
  And User "camfed_web_user" chooses the option to "update status"
  And User "camfed_web_user" should see his previously updated message "status message"
  And User "camfed_web_user" chooses the option to "update status"
  And User "camfed_web_user" replies with new status message "new status message" 
  Then User "camfed_web_user" should get a confirmation that the status was updated successfully
  
  @wip
  Scenario: View status should be reflected on both canvas and ussd app
  