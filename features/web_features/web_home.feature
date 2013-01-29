@javascript
Feature:

  In order to use canvas 
  As an user
  I am on the home page of canvas
  
Background:

When User is on the Sign In page
And User "camfed_user" logs into Canvas with her credentials
Then 

@stage
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

@stage
Scenario: Status updated on web must be reflected on my mobile device
 When User "updates" the status message as "status message"
 Then User status "status message" is updated successfully
 Given I make a new USSD login request
 When User "camfed_user" logs into USSD with correct credentials
 Then User should see the USSD home page 
 And User chooses the option to "update status"
 And User should see his previously updated message "status message"
 And User replies with new status message "new status message" 
 Then User should get a confirmation that the status was updated successfully
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

