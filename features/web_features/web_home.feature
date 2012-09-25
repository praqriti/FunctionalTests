Feature:

  In order to use canvas 
  As an user
  I am on the home page of canvas
  
Background:
Given the following user exists in canvas:
|LOGIN_ID|PASSWORD|
|web_test_user|password|
When I am on the Sign In page
And I enter my login_id "web_test_user" and password "web_test_user"
And "web_test_user" should be successfully logged into canvas


Scenario: Verify if a logged in user can update his status
When User "updates" the status message as "status message"
Then User status "status message" is updated successfully
Then User logs out

Scenario: Verify status is saved only if the create status button is clicked
Given User "enters" the status message as "status updated"
When User navigates to canvas home page
Then User status "status updated" is not updated
Then User logs out

Scenario: Verify that user can update status multiple times
Given User "updates" the status message as "status message"
Then User can update the status again as "new status message"
Then User logs out
