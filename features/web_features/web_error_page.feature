@javascript
Feature:

  In order to keep the common error page
  As a user
  I want to be able to see error page on any exception

  Background:
    Given the following users exists in canvas:
      |USER|
      |test_user|

  Scenario: On any exception user must see 404 error page
    When User is on the Sign In page
    And User "test_user" logs into Canvas with her credentials
    Then "test_user" should see the Canvas home page
    When User navigates to the url "/sen/users/qwerty"
    Then User should see "404" error page
