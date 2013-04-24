Feature:
  In order to resume my profile
  As an user
  I want to login to the system using my mobile device after my session drop

  @wip
  Scenario: Verify user is taken to last menu in USSD in case the session of the user drops and user selects to resume
    Given I make a new USSD login request
    When User "camfed_user" logs into USSD with correct credentials
    Then User should see the USSD home page
    Given User "camfed_user" is enrolled with following groups:
      | name    | type    |
      | Sports  | account |
      | Arts    | account |
      | Science | account |
    And User chooses the option "Groups"
    When User should see the ordered groups list on page "1"
    When User chooses the group "Sports"
    Then User should see the group menu page
    Given I make a new USSD login request
    When User "camfed_user" logs into USSD with correct credentials
    Then User should see the USSD resume page
    When User replies with option "1"
    Then User should see the group menu page
    When User chooses to make announcements
    And User enters "Title for Announcement"
    Then User is asked to "to edit the body of announcement or continue"
    And I make a new USSD login request
    When User "camfed_user" logs into USSD with correct credentials
    When User replies with option "1"
    Then User is asked to "to edit the body of announcement or continue"


  Scenario: Verify user is taken to home menu in USSD in case the session of the user drops and user selects to go to home
    Given I make a new USSD login request
    When User "camfed_user" logs into USSD with correct credentials
    Then User should see the USSD home page
    Given User "camfed_user" is enrolled with following groups:
      | name    | type    |
      | Sports  | account |
      | Arts    | account |
      | Science | account |
    And User chooses the option "Groups"
    When User should see the ordered groups list on page "1"
    When User chooses the group "Sports"
    Then User should see the group menu page
    Given I make a new USSD login request
    When User "camfed_user" logs into USSD with correct credentials
    Then User should see the USSD resume page
    When User replies with option "2"
    Then User should see the USSD home page

  Scenario: Verify User is taken to connection profile if he times out and then resumes on this page
    Given the following users exists in canvas:
      |USER|
      |connected_user1|
      |connected_user2|
    And User "camfed_user" has accepted connection request from:
      |USER|
      |connected_user1|
      |connected_user2|
    And "connected_user2" has his status set to "Hello"
    And I make a new USSD login request
    When User "camfed_user" logs into USSD with correct credentials
    And User chooses the option "Connections"
    When User chooses option "1"
    And User chooses the user "connected_user2"
    Then User should see "Hello"
    And I make a new USSD login request
    When User "camfed_user" logs into USSD with correct credentials
    When User replies with option "1"
    Then User should see "Hello"



 
