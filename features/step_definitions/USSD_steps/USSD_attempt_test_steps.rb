And /^User choose attempt test$/ do
  body = @last_response.parsed_response
  body.merge!({"message" => "2"})
  @last_response = JSONSpecInterface.post("#{SEN_URL}",
                                          :body => body.to_json,
                                          :headers => { "Content-Type" => "application/json"})

end

Then /^User should see question "([^\"]*)"$/ do |question_num|
  body = @last_response.parsed_response
  question = @questions[question_num.to_i - 1]

  body["message"].should == "Q(#{question_num}/#{@questions.count}): #{question[:text]}"

  for i in 1..question[:answers].count
    body["response_map"]["#{i}"]["text"].should == question[:answers]["answer_#{i-1}"]["answer_text"]
  end
  steps %{
      Then the JSON at "session_id" should be "session id"
      Then the JSON at "session_type" should be "SESSION"
      Then the JSON should have "access_token"
      }
end

When /^User choose option "(.*?)"$/ do |option|
  body = @last_response.parsed_response
  body.merge!({"message" => option})
  @last_response = JSONSpecInterface.post("#{SEN_URL}",
                                          :body => body.to_json,
                                          :headers => { "Content-Type" => "application/json"})

end

Then /^User should see message "(.*?)"$/ do |message|
  body = @last_response.parsed_response
  body["message"].should == message
end