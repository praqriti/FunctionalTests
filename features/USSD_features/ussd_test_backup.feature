@javascript
Feature:

  As a User
  I want the questions I answer to be backed up to canvas
  So that i can resume the test from canvas

@stage
Scenario Outline: While a student attempts a quiz the connection is broken

  Given the following test data with questions exists:
    |ROLE   |COURSE  |STATUS  |TEST  |ATTEMPTS  |QUESTIONS|
    |<ROLE> |<COURSE>|<STATUS>|<TEST>|<ATTEMPTS>|<QUESTIONS>|
  And I make a new USSD login request
  And User "camfed_user" logs into USSD with correct credentials
  And User navigates to test page and chooses test "1"
  Then User should see quiz menu for role "<ROLE>" having "<QUESTIONS>" questions and "<ATTEMPTS>" attempts
  When User chooses "Attempt Test"
  Then User should see question "1"
  When User chooses option "2"
  Then User should see question "2"
  When User is on the Sign In page
  When User "camfed_user" logs into Canvas with her credentials
  Then "camfed_user" should see the Canvas home page
  And User navigates to quiz "<TEST>" for course "<COURSE>"
  And User resumes the quiz
  Then User should see option "2" choosen for question "1"

Examples:
  |ROLE   |COURSE |STATUS|TEST |ATTEMPTS|QUESTIONS|
  |Student|Arts   |active|India|1       |2        |
