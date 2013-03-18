@javascript
Feature:

	In order to know about the social surroundings
	As a User
	I want to be able to comment on announcement

  Background:
    Given I make a new USSD login request
    When User "camfed_user" logs into USSD with correct credentials

  Scenario: create comment on announcements on group with truncation
    Given Group "History" has "1" new announcements made by "camfed_user":
      |ANNOUNCEMENTS|
      |My father trained to be a fighter pilot in South Africa|
    Given I make a new USSD login request
    When User "camfed_user" logs into USSD with correct credentials
    Then User should see the USSD home page
    Given User chooses the option "Groups"
    Then User should see the ordered groups list on page "1"
    When User chooses the group "History"
    Then User should see "View Announcements[1]"
    Then User chooses to view announcements
    Then User should see announcement "My father trained to be a fighter pilot in South Africa" made by "camfed_user"
    And User chooses option "1"
    Then User should see "Add Comment"
    And User chooses option "1"
    Then User should see "Enter a comment"
    And User replies with "My First Comment"
    Then User should see "Comment added"
    Then User should see "View Comments[1]"


  Scenario: Not be able to add blank comment on announcement
    Given Group "Geography" has "1" new announcements made by "camfed_user":
      |ANNOUNCEMENTS|
      |My father trained to be a fighter pilot in South Africa|
    Given I make a new USSD login request
    When User "camfed_user" logs into USSD with correct credentials
    Then User should see the USSD home page
    Given User chooses the option "Groups"
    Then User should see the ordered groups list on page "1"
    When User chooses the group "Geography"
    Then User should see "View Announcements[1]"
    Then User chooses to view announcements
    Then User should see announcement "My father trained to be a fighter pilot in South Africa" made by "camfed_user"
    And User chooses option "1"
    Then User should see "Add Comment"
    And User chooses option "1"
    Then User should see "Enter a comment"
    And User replies with ""
    Then User should see "Unable to save a blank comment"
    Then User should see "Enter a comment"


