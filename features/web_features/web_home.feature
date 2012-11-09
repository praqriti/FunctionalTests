@javascript
Feature:

  In order to use canvas 
  As an user
  I am on the home page of canvas
  
Background:

When User is on the Sign In page
And User "camfed_user" logs into Canvas with her credentials
Then "camfed_user" should see the Canvas home page

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

@manual
Scenario: Verify that user cannot enter a status greater than 256 characters
Given User "updates" the status message as
"""
thisisastatusgreaterthan256characterswhichshouldnotbeallowed
"""
Then User status is visible as:
"""
thisisastatusgreaterthan256characters
"""
Then User logs out

