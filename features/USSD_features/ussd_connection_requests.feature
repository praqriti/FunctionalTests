Feature:

	In order to know about the social surroundings
	As a User
	I want to be able to view my connections requests on my mobile device

Background:

    Given the following users exists in canvas:
      |USER|
      |requesting_user1|
      |requesting_user2|
      |requesting_user3|
      |requesting_user4|
      |requesting_user5|
    And User "camfed_user" has pending connection requests from:
      |USER|
      |requesting_user1|
      |requesting_user2|
      |requesting_user3|
      |requesting_user4|
      |requesting_user5|
    And I make a new USSD login request
	  When User "camfed_user" logs into USSD with correct credentials
	  Then User should see the USSD home page
    Given User chooses the option "Connections"
    Then User should see the connections menu

Scenario: View connections requests
    When User chooses option "2"
    Then User should see the list of pending requests for page "1"
    When User chooses the "Next" option
    Then User should see the list of pending requests for page "2"

Scenario: Accept and reject connection
  When User chooses option "2"
  Then User should see the list of pending requests for page "1"
  When User chooses option "1"
  Then User should see connection response options
  When User chooses "Accept" option
  Then User should see the message "connection_request_accepted" with "requesting_user5"
  When User chooses the "Previous" option
  Then User should see the list of pending requests for page "1"
  When User chooses option "1"
  Then User should see connection response options
  When User chooses "Reject" option
  Then User should see the message "connection_request_rejected" with "requesting_user4"
  When User chooses the "Previous" option
  Then User should see the list of pending requests for page "1"
