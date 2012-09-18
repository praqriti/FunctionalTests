Feature:

  In order to use canvas 
  As an user
  I am on the home page of canvas
  

Scenario: Verify if a logged in user can update his status
Given User is logged into SEN
When User lands on her homepage
And User is able to see the status box
And User updates her status
Then The status is successfully updated

Scenario: Verify status is saved only if the create status button is clicked
Given User is logged into SEN
When User lands on her homepage
And User is able to see the status box
And User enters her status
And User refreshes the page
Then the status is not updated

Scenario: Verify that user can update status multiple times
