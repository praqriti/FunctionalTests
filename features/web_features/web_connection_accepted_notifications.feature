@javascript
Feature:

  In order to use canvas
  As an user
  I am on the home page of canvas
  I get notifications for connections accept

  
  Scenario: Verify if connection notification is sent to requesting user
   Given the following users exists in canvas:
     |USER|
     |camfed_friend_1|
    Given the following connections exist:
     |REQUESTING_FRIEND|ACCEPTING_FRIEND|
     |camfed_friend_1|camfed_user|
    When User is on the Sign In page
    And User "camfed_user" logs into Canvas with her credentials
    When User clicks on connection notification group
    Then User should see connection notifications on web:
     | REQUESTING_FRIEND    | ACCEPTING_FRIEND |
     |camfed_friend_1       |camfed_user|
    Then notification should take user to the "private" wall of "camfed_friend_1"
    Then User logs out
    
  Scenario: Verify if connection notification is sent to accepting user
  Given the following users exists in canvas:
     |USER|
     |camfed_friend_1|
    Given the following connections exist:
     |REQUESTING_FRIEND|ACCEPTING_FRIEND|
     |camfed_friend_1  |camfed_user|
    When User is on the Sign In page
    And User "camfed_friend_1" logs into Canvas with her credentials
    When User clicks on connection notification group
    Then User should see connection notifications on web:
     | REQUESTING_FRIEND    | ACCEPTING_FRIEND |
     |camfed_friend_1       |camfed_user|
     Then User logs out

  Scenario: Verify if connection notification is sent to the friend of the requesting user 
  Given the following users exists in canvas:
     |USER|
     |camfed_friend_1|
     |camfed_friend_2|
    Given the following connections exist:
     |REQUESTING_FRIEND|ACCEPTING_FRIEND|
     |camfed_friend_1  |camfed_friend_2|
     |camfed_friend_1  |camfed_user    |
    When User is on the Sign In page
    And User "camfed_friend_2" logs into Canvas with her credentials
    When User clicks on connection notification group
    Then User should see connection notifications on web:
    | REQUESTING_FRIEND    | ACCEPTING_FRIEND |
    |camfed_friend_1       |camfed_user|
    Then User logs out  

  Scenario: Verify if connection notification is sent to the friend of the accepting user 
  Given the following users exists in canvas:
     |USER|
     |camfed_friend_1|
     |camfed_friend_2|
    Given the following connections exist:
     |REQUESTING_FRIEND|ACCEPTING_FRIEND|
     |camfed_friend_1  |camfed_friend_2|
     |camfed_user      |camfed_friend_1|
    When User is on the Sign In page
    And User "camfed_friend_2" logs into Canvas with her credentials
    When User clicks on connection notification group
    Then User should see connection notifications on web:
    | REQUESTING_FRIEND    | ACCEPTING_FRIEND |
    |camfed_user           |camfed_friend_1|
    Then User logs out 
    
Scenario: Verify if connection accepted notification is sent to common friends
    Given the following users exists in canvas:
      |USER|
      |camfed_friend_1|
      |camfed_friend_2|
      |camfed_friend_3|
      |camfed_common_friend|
    Given the following connections exist:
     |REQUESTING_FRIEND|ACCEPTING_FRIEND|
     |camfed_common_friend|camfed_user|
     |camfed_common_friend|camfed_friend_1| 
     |camfed_common_friend|camfed_friend_2| 
     |camfed_common_friend|camfed_friend_3|
    When User is on the Sign In page
    And User "camfed_common_friend" logs into Canvas with her credentials
    When User clicks on connection notification group
    Then User should see connection notifications on web:
    |REQUESTING_FRIEND|ACCEPTING_FRIEND|
     |camfed_common_friend|camfed_user|
     |camfed_common_friend|camfed_friend_1| 
     |camfed_common_friend|camfed_friend_2| 
     |camfed_common_friend|camfed_friend_3|  
    Then User logs out
    
@integration
  Scenario: Verify if connection accepted notifications are consistent on web and USSD
     Given the following users exists in canvas:
        |USER|
        |camfed_friend_1|
        |camfed_friend_2|
        |camfed_friend_3|
        |camfed_common_friend|
      Given the following connections exist:
       |REQUESTING_FRIEND|ACCEPTING_FRIEND|
       |camfed_common_friend|camfed_user|
       |camfed_common_friend|camfed_friend_1| 
       |camfed_common_friend|camfed_friend_2| 
       |camfed_common_friend|camfed_friend_3|
    When User is on the Sign In page
    And User "camfed_common_friend" logs into Canvas with her credentials
    Then User should see "4" connection notifications on home page
    Then User logs out
    
    And I make a new USSD login request
    When User "camfed_common_friend" logs into USSD with correct credentials
    Then User should see the USSD home page
    Given User chooses the option "Notifications"
    When User should see the notifications menu with "1 Connection Request Accepted (4)"
    Then User replies with option "1"
    Then User should see connection notifications on USSD:
      |REQUESTING_FRIEND    |ACCEPTING_FRIEND|
       |camfed_common_friend|camfed_friend_3|
       |camfed_common_friend|camfed_friend_2| 
       |camfed_common_friend|camfed_friend_1| 
       |camfed_common_friend|camfed_user|
  
    
    
    
