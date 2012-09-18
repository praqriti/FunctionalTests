Feature:

  In order to control the admin functionality
  As an admin
  I want to login to the system
  
  @leave_the_window_open
  Scenario: login to canvas as a user using CAS 

  Given I am on the 'Sign In' page
  When I enter my login_id "user_one" and password "user_one"
  Then "user_one" should be successfully logged into canvas
  