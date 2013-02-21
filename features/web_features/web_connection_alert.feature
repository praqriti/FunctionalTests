@javascript
Feature:

  In order to use canvas
  As an user
  I am on the home page of canvas
  I get notifications for connections accept

  Background:
    Given the following users exists in canvas:
      |USER|
      |camfed_friend_1|
      |camfed_friend_2|
      |camfed_friend_3|
      |camfed_friend_4|
      |camfed_friend_5|
      
    When User "camfed_user" has pending connection requests from:
                |USER|
                |camfed_friend_1|
                |camfed_friend_2|
                |camfed_friend_3|
                |camfed_friend_4|
                |camfed_friend_5|    
    When User is on the Sign In page
    When User "camfed_user" logs into Canvas with her credentials
    
Scenario: User must be able to navigate to connection request page from the alert
    Given User must see the connection request of "camfed_friend" on the home page
    When User navigates to canvas home page
    Then User can navigate to the connection request page from the connection alert
    Then User can "accept" the connection request from "camfed_friend"
    Then User does not see the connection request alert

    