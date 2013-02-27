@javascript
Feature:

	In order to know about the social surroundings
	As a User
	I want to be able to comment on status of my connection

Background:
    Given the following users exists in canvas:
      |USER|
      |connected_user1|
    And User "camfed_user" is connected to:
      |USER|
      |connected_user1|

  Scenario: Comment on a connection's status
    Given "connected_user1" has his status set to "oolala le lo"
    And I make a new USSD login request
    When User "camfed_user" logs into USSD with correct credentials
    Then User should see the USSD home page
    Given User chooses the option "Connections"
    Then User should see the connections menu
    When User chooses option "1"
    Then User should see the list of connected users for page "1"
    When User chooses option "1"
    Then User should see the current status of "connected_user1"
    Then User should not see "View Comments"
    Then User should see "Add Comment"
    When User chooses option "1"
    Then User should see "Enter a new comment"
    When User replies with "My First Comment"
    Then User should see "Comment added"
    Then User should see "View Comments[1]"

  Scenario: Verify User is not allowed to enter a blank comment
    Given "connected_user1" has his status set to "oolala le lo"
    And I make a new USSD login request
    When User "camfed_user" logs into USSD with correct credentials
    Then User should see the USSD home page
    Given User chooses the option "Connections"
    Then User should see the connections menu
    When User chooses option "1"
    Then User should see the list of connected users for page "1"
    When User chooses option "1"
    Then User should see the current status of "connected_user1"
    Then User should not see "View Comments"
    Then User should see "Add Comment"
    When User chooses option "1"
    Then User should see "Enter a new comment"
    When User replies with ""
    Then User should see "Comment cannot be blank."
    Then User should see "Enter a new comment"