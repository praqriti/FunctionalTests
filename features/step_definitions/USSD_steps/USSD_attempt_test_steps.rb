And /^User chooses attempt test$/ do
  body = @last_response.parsed_response
  body.merge!({"message" => "2"})
  @last_response = JSONSpecInterface.post("#{SEN_URL}",
                                          :body => body.to_json,
                                          :headers => { "Content-Type" => "application/json"})

end

Then /^User should see question "([^\"]*)"$/ do |question_num|
  body = @last_response.parsed_response
  question = @questions[question_num.to_i - 1]

  body["message"].include? "Q(#{question_num}/#{@questions.count}): #{question[:text]}"

  for i in 1..question[:answers].count
    body["response"]["response_map"]["#{i}"]["text"].should == question[:answers]["answer_#{i-1}"]["answer_text"]
  end
  steps %{
      Then the JSON at "session_id" should be "session id"
      Then the JSON at "session_type" should be "SESSION"
      Then the JSON should have "access_token"
      }
end

When /^User chooses option "(.*?)"$/ do |option|
  body = @last_response.parsed_response
  body.merge!({"message" => option})
  @last_response = JSONSpecInterface.post("#{SEN_URL}",
                                          :body => body.to_json,
                                          :headers => { "Content-Type" => "application/json"})

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
