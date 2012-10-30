When /^User chooses course "([^\"]*)"$/ do |course_no|
  course_no = course_no.to_i
  body = @last_response.parsed_response
  body.merge!({"message" => "#{course_no}"})
  @last_response = JSONSpecInterface.post("#{SEN_URL}",
                                          :body => body.to_json,
                                          :headers => { "Content-Type" => "application/json"})
end


Then /^User should see the tests for page 1$/ do
  user_id = CanvasUserInterface.get_user_id
  actual_response = @last_response.parsed_response

  s_no = 1

  @quizzes[0..3].each do |quiz|
    actual_response["response_map"]["#{s_no}"]["text"].should == quiz["TEST"]
    s_no+=1
  end
  actual_response["response_map"]["0"]["text"].should == "Home"
  actual_response["response_map"]["0"]["url"].should  == "sen/users/#{user_id}"

  steps %{
		Then the JSON at "session_id" should be "session id"
		Then the JSON at "session_type" should be "SESSION"
		Then the JSON should have "access_token"
    		}
end

Given /^User publishes the course "([^\"]*)"$/ do |course_name|
  @course = @enrolled_courses.select { |c| c.name == course_name }.first

  steps %{
          When User is on the Sign In page
          And User "camfed_student" logs into Canvas with her credentials
          Then "camfed_student" should see the Canvas home page
          And User publishes the "#{course_name}" course
        }
end

And /^User chooses test "([^\"]*)"$/ do |test_no|
  test_no = test_no.to_i
  body = @last_response.parsed_response
  body.merge!({"message" => "#{test_no}"})
  @last_response = JSONSpecInterface.post("#{SEN_URL}",
                                          :body => body.to_json,
                                          :headers => { "Content-Type" => "application/json"})
end

Then /^User should see the teachers menu$/ do
  user_id = CanvasUserInterface.get_user_id
  actual_response = @last_response.parsed_response

  actual_response["response_map"]["1"]["text"].should == "View Report"
  actual_response["response_map"]["0"]["text"].should == "Home"
  actual_response["response_map"]["0"]["url"].should  == "sen/users/#{user_id}"

  steps %{
		Then the JSON at "session_id" should be "session id"
		Then the JSON at "session_type" should be "SESSION"
		Then the JSON should have "access_token"
    		}
end

Then /^User should see the students menu$/ do
  user_id = CanvasUserInterface.get_user_id
  actual_response = @last_response.parsed_response

  actual_response["response_map"]["2"]["text"].should == "Attempt Quiz"
  actual_response["response_map"]["1"]["text"].should == "View Score"
  actual_response["response_map"]["0"]["text"].should == "Home"
  actual_response["response_map"]["0"]["url"].should  == "sen/users/#{user_id}"

  steps %{
		Then the JSON at "session_id" should be "session id"
		Then the JSON at "session_type" should be "SESSION"
		Then the JSON should have "access_token"
    		}
end
