@javascript
Feature:

  In order to control the admin functionality
  As an admin
  I want to login to the system
  
  Scenario: login to canvas as a user using CAS
  Given the following user exists in canvas:
  |LOGIN_ID|PASSWORD|
  |web_test_user2|password| 
  When I am on the Sign In page
  And I enter my login_id "web_test_user2" and password "web_test_user2"
  Then "web_test_user2" should be successfully logged into canvas
  Then User logs out
  