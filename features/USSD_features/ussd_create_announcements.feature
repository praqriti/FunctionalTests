@javascript
Feature:

  In order to know the Groups I have enrolled for
  As a User
  I want to be able to make announcements on a group

  Background:

    Given I make a new USSD login request
    When User "camfed_user" logs into USSD with correct credentials
    Then User should see the USSD home page

  Scenario: Create an announcement on groups which user is attached
    Given User "camfed_user" is enrolled with following groups:
      |name         |
      |History      |
    Given User chooses the option "Groups"
    Then User should see the ordered groups list on page "1"
    Then User chooses group "1"
    Then User chooses to make announcements
    Then User is asked to "Enter Title of Announcement"
    And  User enters "Title for Announcement"
    Then User is asked to "to edit the body of announcement or continue"
    And User chooses "Skip to Groups" option
    Then User should see confirmation for announcement created
    Then User should see the ordered groups list on page "1"
    Then User chooses group "1"
    Then User chooses to view announcements
    Then User should see announcement "Title for Announcement" made by "camfed_user"

  Scenario: Create an announcement on groups which user is attached and change body
    Given User "camfed_user" is enrolled with following groups:
      |name         |
      |History      |
    Given User chooses the option "Groups"
    Then User should see the ordered groups list on page "1"
    Then User chooses group "1"
    Then User chooses to make announcements
    Then User is asked to "Enter Title of Announcement"
    And  User enters "Title for Announcement"
    Then User is asked to "to edit the body of announcement or continue"
    And  User enters "Body for Announcement"
    Then User should see confirmation for announcement created
    Then User should see the ordered groups list on page "1"
    Then User chooses group "1"
    Then User chooses to view announcements
    Then User should see announcement "Title for Announcement" made by "camfed_user"