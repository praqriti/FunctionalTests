Feature:

	In order to know my enrollments in a course
	As a User
	I want to be able to view information about the course

Scenario Outline:
Given I make a new USSD login request
When User "camfed_user" logs into USSD with correct credentials
Then User should see the USSD home page
Given User "camfed_user" is enrolled with following courses:
|COURSE     |ROLE   |STATUS   |
|<COURSE>   |<ROLE> |<STATUS> |
Given User chooses the option "Courses"
When User chooses the course "<COURSE>"
Then User should see the message "<MESSAGE>"

Examples:
|COURSE     |ROLE   |STATUS |MESSAGE|
|History    |Teacher|active |teacher_with_no_quiz|
|Chinese    |Teacher|pending|teacher_with_pending_invitation|
|Biology    |Student|active |student_with_no_quiz|
|Computer   |Student|pending|student_with_pending_invitation|

@stage
Scenario: Verify student course info with pagination
Given I make a new USSD login request
When User "camfed_user" logs into USSD with correct credentials
Then User should see the USSD home page
  Given User "camfed_user" is enrolled with following courses:
  |COURSE     |ROLE    |STATUS|
  |History    |Student |active|
  |Physics    |Student |active|
  |Geography  |Student |active|
  |Maths      |Student |active|
  |Biology    |Student |pending|
  Given User chooses the option "Courses"
  When User chooses the "Next" option
  And User chooses the course "Biology"
  Then User should see the message "student_with_pending_invitation"

@stage
Scenario: Verify teacher course info with pagination
Given User "camfed_user" is enrolled with following courses:
|COURSE     |ROLE    |STATUS|
|Hindi      |Student |pending|
|Chemistry  |Student |active|
|Arts       |Teacher |active|
|Biology    |Student |active|
|English    |Teacher |pending|
Given I make a new USSD login request
When User "camfed_user" logs into USSD with correct credentials
Then User should see the USSD home page
And User chooses the option "Courses"
When User chooses the "Next" option
And User chooses the course "English"
Then User should see the message "teacher_with_pending_invitation"

@manual
Scenario: Verify selecting invalid option throws appropriate error
	    
