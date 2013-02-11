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
    Then User should see connection notifications containing link of "Mathew" profile
    When User clicks on connection notification group
    Then User should see connected user notification of "Mathew" and "camfed_user"
    Then User logs out
    

  Scenario: Verify if connection accepted notification is sent to sending user friend
    Given User "camfed_user_friend" is enrolled with following courses:
      |COURSE     |ROLE    |STATUS|
      |History    |Student |active|
    When User is on the Sign In page
    And User "camfed_user_friend" logs into Canvas with her credentials
    Then User should see connection notifications containing link of "camfed_user" profile
    When User clicks on connection notification group
    Then User should see connected user notification of "Mathew" and "camfed_user"
    Then User logs out
    

  Scenario: Verify if connection accepted notification is sent to receiving user
    Given User "Mathew" is enrolled with following courses:
      |COURSE     |ROLE    |STATUS|
      |History    |Student |active|
    When User is on the Sign In page
    And User "Mathew" logs into Canvas with her credentials
    Then User should see connection notifications containing link of "camfed_user" profile
    When User clicks on connection notification group
    Then User should see connected user notification of "Mathew" and "camfed_user"
    Then User logs out
    

  Scenario: Verify if connection accepted notification is sent to receiving user friend
    Given User "Mathew_friend" is enrolled with following courses:
      |COURSE     |ROLE    |STATUS|
      |History    |Student |active|
    When User is on the Sign In page
    And User "Mathew_friend" logs into Canvas with her credentials
    Then User should see connection notifications containing link of "Mathew" profile
    When User clicks on connection notification group
    Then User should see connected user notification of "Mathew" and "camfed_user"
    Then User logs out
    

@stage
  Scenario: Verify if connection accepted notification is sent to common friends
    Given User "Common_friend" is enrolled with following courses:
      |COURSE     |ROLE    |STATUS|
      |History    |Student |active|
    When User is on the Sign In page
    And User "Common_friend" logs into Canvas with her credentials
    Then User should see connection notifications containing link of "Mathew" profile
    When User clicks on connection notification group
    Then User should see connected user notification of "Mathew" and "camfed_user"
    Then User logs out
    
@integration
  Scenario: Verify if connection accepted notification is sent to common friends
    Given User "Common_friend" is enrolled with following courses:
      |COURSE     |ROLE    |STATUS|
      |History    |Student |active|
    When User is on the Sign In page
    And User "Common_friend" logs into Canvas with her credentials
    Then User should see connection notifications containing link of "Mathew" profile
    When User clicks on connection notification group
    Then User should see connected user notification of "Mathew" and "camfed_user"
    Then User logs out
    
    And I make a new USSD login request
    When User "Common_friend" logs into USSD with correct credentials
    Then User should see the USSD home page
    Given User chooses the option "Notifications"
    When User should see the notifications menu with "1 Connection Request Accepted (2)"
    Then User replies with option "1"
    And "camfed_user" should see connection notification for user "Mathew" with page_no "1"
    When User chooses the "Next" option
    And "camfed_user" should see connection notification for user "camfed_user" with page_no "2"
