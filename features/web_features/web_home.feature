@wip
@javascript
Feature:

  In order to use canvas 
  As an user
  I am on the home page of canvas
  
Background:



When I am on the Sign In page
And User "camfed_student" logs into Canvas with her credentials
Then "camfed_student" should see the Canvas home page

#Bug No. 254
@wip
Scenario: Verify if a logged in user can update his status
When User "updates" the status message as "status message"
Then User status "status message" is updated successfully
# Then clear cookies
Then User logs out

#Bug No. 254
@wip
Scenario: Verify status is saved only if the create status button is clicked
Given User "enters" the status message as "status updated"
When User navigates to canvas home page
Then User status "status updated" is not updated
# Then clear cookies
Then User logs out


#Bug No. 254
@wip
Scenario: Verify that user can update status multiple times
Given User "updates" the status message as "status message"
Then User can update the status again as "new status message"
# Then clear cookies
Then User logs out

