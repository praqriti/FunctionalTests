@javascript
Feature:

	In order to know about the social surroundings
	As a User
	I want to be able to view comment on status of my connection

Background:
  Given the following users exists in canvas:
      |USER|
      |camfed_friend_1|  
      |camfed_friend_2|  
      |camfed_friend_3|  
    
@wip
Scenario: Verify correct notification is given to user when there are no comments
  And I make a new USSD login request
  When User "camfed_user" logs into USSD with correct credentials
  Then User should see the USSD home page
  Given User chooses the option "Connections"
  Then User should see the connections menu with 0 connections and 0 requests
  When User chooses option "1"
  When User chooses option "1"
  Then User should see "No comments added yet"
                       

Scenario: View "View comments" option on connections status with count of comments
  Given User "camfed_friend_1" has the following comment notifications:
             |COMMENTED_BY   |COMMENT|
             |camfed_user    |first comment|
             |camfed_friend_2|second comment|
             |camfed_friend_3|third comment|
  And I make a new USSD login request
  When User "camfed_user" logs into USSD with correct credentials
  Then User should see the USSD home page
  Given User chooses the option "Connections"
  Then User should see the connections menu with 1 connections and 0 requests
  When User chooses option "1"
  When User chooses option "1"
  Then User should see the current status of "camfed_friend_1"
  Then User should see "View Comments[3]"
  When User chooses option "2"
  Then User should see comment "third comment" made by "camfed_friend_3"  
  Then User should not see "Previous"
  When User chooses the "Next" option
  Then User should see comment "second comment" made by "camfed_friend_2"
  Then User should see the "Next" and "Previous" option
  When User chooses the "Next" option
  Then User should see comment "first comment" made by "camfed_user"
  Then User should not see "Next"
  Then User should see "Previous"
