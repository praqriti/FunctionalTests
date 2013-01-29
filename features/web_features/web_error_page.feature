@javascript
Feature:

  In order to keep the common error page
  As a user
  I want to be able to see error page on any exception

  Background:
    Given User is on the Sign In page
    And User "camfed_user" logs into Canvas with her credentials
 
  Scenario: On any exception user must see 404 error page  
    When User navigates to the url "/sen/users/qwerty"
    Then User should see "404" error page
    Then User logs out

  Scenario: User must see the unauthorised page if he is not authorised to view a page
    When User navigates to the url "/sen/users/2/posts"
    Then User should see "unauthorised" error page
    Then User logs out
  
  Scenario: On any exception user must see 404 error page
    When User navigates to the url "/sen/qwerty"
    Then User should see "404" error page
    Then User logs out
    
  
    
