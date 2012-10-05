@javascript
Feature:

  In order to control the admin functionality
  As an admin
  I want to login to the system
  
  Scenario: login to canvas as a user using CAS
  
  Given the following user exists in canvas:
  |LOGIN_ID|PASSWORD|
  |camfed_webtest_user|password| 
  
  When I am on the Sign In page
  And I enter my login_id "camfed_webtest_user" and password "camfed_webtest_user"
  Then "camfed_webtest_user" should be successfully logged into canvas
  Then User logs out
  