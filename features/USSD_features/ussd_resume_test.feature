@javascript
Feature:

  As a User
  I want the questions I answer to be backed up to canvas
  So that I can resume the test from canvas

Scenario Outline: Student resumes the test

  Given the following test data with questions exists:
    |ROLE   |COURSE  |STATUS  |TEST  |ATTEMPTS|QUESTIONS|
    |<ROLE> |<COURSE>|<STATUS>|<TEST>|<ATTEMPTS>|<QUESTIONS>|
  And I make a new USSD login request
  And User "camfed_user" logs into USSD with correct credentials
  And User navigates to test page and chooses test "1"
  Then User should see quiz menu for role "<ROLE>" having "2" questions and "2" attempts
  When User chooses "Attempt Test"
  Then User should see question "1"
  When User chooses option "2"
  Then User should see question "2"

  And I make a new USSD login request
  And User "camfed_user" logs into USSD with correct credentials
  And User navigates to test page and chooses test "1"
  Then User should see quiz menu for role "<ROLE>" having "2" questions and "2" attempts
  When User chooses "Attempt Test"
  Then User should see question "2"

Examples:  
  |ROLE   |COURSE      |STATUS|TEST         |ATTEMPTS|QUESTIONS|
  |Student|Chemistry   |active|Hybridization|2			 |2        |
