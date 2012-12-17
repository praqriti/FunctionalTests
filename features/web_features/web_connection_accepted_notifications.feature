@javascript
Feature:

  In order to use canvas
  As an user
  I am on the home page of canvas
  I get notifications for connections accept

  Background:
    Given the following users exists in canvas:
      |USER|
      |Mathew|
      |camfed_user_friend|
      |Mathew_friend|
      |Common_friend|
    And "camfed_user" is connected to "camfed_user_friend"
    And "camfed_user" is connected to "Common_friend"
    And "Mathew" is connected to "Mathew_friend"
    And "Mathew" is connected to "Common_friend"
    And "camfed_user" is connected to "Mathew"

  Scenario: Verify if connection accepted notification is sent to sending user
    Given User "camfed_user" is enrolled with following courses:
      |COURSE     |ROLE    |STATUS|
      |History    |Student |active|
    When User is on the Sign In page
    And User "camfed_user" logs into Canvas with her credentials
    Then "camfed_user" should see the Canvas home page
    Then User should see connected user notification of "Mathew" and "camfed_user"

  Scenario: Verify if connection accepted notification is sent to sending user friend
    Given User "camfed_user_friend" is enrolled with following courses:
      |COURSE     |ROLE    |STATUS|
      |History    |Student |active|
    When User is on the Sign In page
    And User "camfed_user_friend" logs into Canvas with her credentials
    Then "camfed_user_friend" should see the Canvas home page
    Then User should see connected user notification of "Mathew" and "camfed_user"

  Scenario: Verify if connection accepted notification is sent to receiving user
    Given User "Mathew" is enrolled with following courses:
      |COURSE     |ROLE    |STATUS|
      |History    |Student |active|
    When User is on the Sign In page
    And User "Mathew" logs into Canvas with her credentials
    Then "Mathew" should see the Canvas home page
    Then User should see connected user notification of "Mathew" and "camfed_user"

  Scenario: Verify if connection accepted notification is sent to receiving user friend
    Given User "Mathew_friend" is enrolled with following courses:
      |COURSE     |ROLE    |STATUS|
      |History    |Student |active|
    When User is on the Sign In page
    And User "Mathew_friend" logs into Canvas with her credentials
    Then "Mathew_friend" should see the Canvas home page
    Then User should see connected user notification of "Mathew" and "camfed_user"

  Scenario: Verify if connection accepted notification is sent to common friebds
    Given User "Common_friend" is enrolled with following courses:
      |COURSE     |ROLE    |STATUS|
      |History    |Student |active|
    When User is on the Sign In page
    And User "Common_friend" logs into Canvas with her credentials
    Then "Common_friend" should see the Canvas home page
    Then User should see connected user notification of "Mathew" and "camfed_user"