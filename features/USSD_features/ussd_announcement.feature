@javascript
Feature:

  In order to know the Groups I have enrolled for
  As a User
  I want to be able to view the list of my groups on my mobile device

  Background:

    Given I make a new USSD login request
    When User "camfed_user" logs into USSD with correct credentials
    Then User should see the USSD home page

  Scenario: View list of announcement on groups which user is attached
    Given User "camfed_user" is enrolled with following groups:
      |name         |
      |History      |
    And "History" has announcement "First Announcement" made by "camfed_user"
    Given User chooses the option "Groups"
    Then User should see the ordered groups list on page "1"
    Then User chooses group "1"
    Then User chooses to view announcements
    Then User should see announcement "First Announcement" made by "camfed_user"
