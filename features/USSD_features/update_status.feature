Feature:

  In order to access my profile 
  As an user
  I want to update my status using my mobile device
  

Scenario: Update and view new status update from USSD

Given I make a new login request
When I enter the login credentials as "camfed@thoughtworks.com" with password "camfed"
And I should see the home page for user "camfed@thoughtworks.com"
And User "camfed@thoughtworks.com" chooses the option to "update status"
And User "camfed@thoughtworks.com" replies with new status message "new status"
And User "camfed@thoughtworks.com" should get a confirmation that the status was updated successfully
And User "camfed@thoughtworks.com" chooses the option to "update status"
Then User "camfed@thoughtworks.com" should see his previously updated message "new status"

Scenario: Verify blank status update from USSD

Given I make a new login request
When I enter the login credentials as "camfed@thoughtworks.com" with password "camfed"
And I should see the home page for user "camfed@thoughtworks.com"
And User "camfed@thoughtworks.com" chooses the option to "update status"
When User "camfed@thoughtworks.com" replies with new status message " "
Then User "camfed@thoughtworks.com" should get a confirmation that the status was updated successfully
And User "camfed@thoughtworks.com" chooses the option to "update status"
Then User "camfed@thoughtworks.com" should see his previously updated message " "


Scenario: Verify back from update page from USSD

Given I make a new login request
When I enter the login credentials as "camfed@thoughtworks.com" with password "camfed"
And I should see the home page for user "camfed@thoughtworks.com"
When User "camfed@thoughtworks.com" replies "#" to go back to home page
Then I should see the home page for user "camfed@thoughtworks.com"


Scenario: Verify no error on status update longer than max alllowed length from USSD

Given I make a new login request
When I enter the login credentials as "camfed@thoughtworks.com" with password "camfed"
And I should see the home page for user "camfed@thoughtworks.com"
And User "camfed@thoughtworks.com" chooses the option to "update status"
When User "camfed@thoughtworks.com" replies with a new status message: 
"""
12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
"""
Then User "camfed@thoughtworks.com" should get a confirmation that the status was updated successfully
And User "camfed@thoughtworks.com" chooses the option to "update status"
Then User "camfed@thoughtworks.com" should see his previously updated message:
"""
1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567...
"""




