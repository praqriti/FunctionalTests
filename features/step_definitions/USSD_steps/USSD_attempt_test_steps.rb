And /^User chooses "Attempt Test"$/ do
  steps %{
   Then User replies with option "2"   
	}
end

And /^User chooses "View Score"$/ do
	steps %{
   Then User replies with option "1"   
	}
end

And /^User chooses "View Report"$/ do
	steps %{
   Then User replies with option "1"   
	}
end

Then /^User chooses "Back" option$/ do
	steps %{
   Then User replies with option "*"   
	}
end

Then /^User should see question "([^\"]*)"$/ do |question_num|
  body = @last_response.parsed_response
  question = @questions[question_num.to_i - 1]

  body["message"].include? "Q(#{question_num}/#{@questions.count}): #{question[:text]}"

  for i in 1..question[:answers].count
    body["message"].include?(question[:answers]["answer_#{i-1}"]["answer_text"]) == true
  end
  
  steps %{
      Then the JSON at "session_id" should be "#{@session_id}"
      Then the JSON at "session_type" should be "SESSION"
      Then the JSON should have "access_token"
      }
end

When /^User chooses option "(.*?)"$/ do |option|
	steps %{
   Then User replies with option "#{option.to_i}"   
	}
end

And /^User skips the question$/ do
	steps %{
   Then User replies with option "#"   
	}
end

Then /^User should see message "(.*?)"$/ do |message|
  body = @last_response.parsed_response
  body["message"].include? message
end

And /^User navigates to test page and chooses test "(.*?)"$/ do |test_no|
	steps %{
		Then User should see the USSD home page
		Given User chooses the option "Courses"
		When User should see the courses list
		And User chooses course "1"
		Then User should see the tests for page "1"
		And User chooses test "1"
	}
end

Then /^the Quiz should be submitted$/ do
  @quizzes[0].is_submitted?.should be_true
end
