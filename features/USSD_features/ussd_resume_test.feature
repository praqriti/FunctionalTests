@javascript
Feature:

  As a User
  I want the questions i answer to be backed up to canvas
  So that i can resume the test from canvas

Scenario Outline: Student resumes the test

  Given the following test data with questions exists:
    |ROLE   |COURSE  |STATUS  |TEST  |
    |<ROLE> |<COURSE>|<STATUS>|<TEST>|
  And I make a new USSD login request
  And User "camfed_user" logs into USSD with correct credentials
  And User navigates to test page and chooses test "1"
  Then User should see the "<ROLE>" menu
  When User chooses attempt test
  Then User should see question "1"
  When User chooses option "2"
  Then User should see question "2"

  And I make a new USSD login request
  And User "camfed_user" logs into USSD with correct credentials
  And User navigates to test page and chooses test "1"
  Then User should see the "<ROLE>" menu
  When User chooses attempt test
  Then User should see question "2"


Examples:
  |ROLE   |COURSE |STATUS|TEST|
  |Student|Arts   |active|India|