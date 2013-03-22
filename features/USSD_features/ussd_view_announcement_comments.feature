@javascript
Feature:
  In order to know the announcement comments for the announcements I have enrolled for
  As a User
  I want to be able to view the list of comments on announcement on my mobile device

Background:
  Given the following users exists in canvas:
    |USER|
    |camfed_user_2|

Scenario: View "View comments" option on announcement with count of comments
  Given Group "History" has "1" new announcements made by "camfed_user_2":
    |ANNOUNCEMENTS|
    |My father trained to be a fighter pilot in South Africa|
  Given Group "History" with announcement "My father trained to be a fighter pilot in South Africa" has "1" new comments made by "camfed_user"
    |COMMENTS|
    |Comment 1 on announcement|
  Given I make a new USSD login request
  When User "camfed_user_2" logs into USSD with correct credentials
  Then User should see the USSD home page
  Given User chooses the option "Groups"
  Then User should see the ordered groups list on page "1"
  When User chooses the group "History"
  Then User should see "View Announcements[1]"
  Then User chooses to view announcements
  Then User should see announcement "My father trained to be a fighter pilot in South Africa" made by "camfed_user_2"
  When User chooses option "1"
  Then User should see "View Comments[1]"

Scenario: View "Comments" on announcement by selecting View Comment option
  Given Group "History" has "1" new announcements made by "camfed_user_2":
    |ANNOUNCEMENTS|
    |My father trained to be a fighter pilot in South Africa|
  Given Group "History" with announcement "My father trained to be a fighter pilot in South Africa" has "1" new comments made by "camfed_user"
    |COMMENTS|
    |Comment 1 on announcement|
  Given I make a new USSD login request
  When User "camfed_user_2" logs into USSD with correct credentials
  Then User should see the USSD home page
  Given User chooses the option "Groups"
  Then User should see the ordered groups list on page "1"
  When User chooses the group "History"
  Then User should see "View Announcements[1]"
  Then User chooses to view announcements
  Then User should see announcement "My father trained to be a fighter pilot in South Africa" made by "camfed_user_2"
  When User chooses option "1"
  Then User should see "View Comments[1]"
  When User chooses option "2"
  Then User should see comment "Comment 1 on announcement" made by "camfed_user"
  Then User should see "Previous Menu"
  Then User should not see "Previous"
  Then User should not see "Next"
