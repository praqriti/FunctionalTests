Feature:
  In order to use this app in my country
  As an user
  I would like to have it in the corresponding language

@wip
Scenario:
  Given the following users exists in canvas:
    |     USER      | LOCALE|
    | camfed_user_1 | sw    |
  And I make a new USSD login request
  When User "camfed_user_1" logs into USSD with correct credentials
  Then I should see the app in "sw"