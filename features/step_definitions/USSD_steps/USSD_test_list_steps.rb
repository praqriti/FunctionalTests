When /^User chooses course "([^\"]*)"$/ do |course_no|
  course_no = course_no.to_i
  body = @last_response.parsed_response
  body.merge!({"message" => "#{course_no}"})
  @last_response = JSONSpecInterface.post("#{SEN_URL}",
                                          :body => body.to_json,
                                          :headers => { "Content-Type" => "application/json"})
end


Then /^User should see the tests for page "([^\"]*)"$/ do |page_no|
  actual_response = @last_response.parsed_response
	page_no = page_no.to_i
	rpp = "#{RECORDS_PER_PAGE}".to_i
	s_no = (rpp * (page_no-1)) + 1
	start_index = rpp * (page_no-1)
	end_index = start_index + (rpp-1)
	@quizzes[start_index..end_index].each do |quiz|
		actual_response["response_map"]["#{s_no}"]["text"].should == quiz
		s_no+=1
	end
	actual_response["response_map"]["0"]["text"].should == "Home"
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


Then /^User should see the "([^\"]*)" menu$/ do |role|
  user_id = CanvasUserInterface.get_user_id
  actual_response = @last_response.parsed_response
  if (role == "student")
    actual_response["response_map"]["2"]["text"].should == "Attempt Quiz"
    actual_response["response_map"]["1"]["text"].should == "View Score"   
  elsif (role == "teacher")
    actual_response["response_map"]["1"]["text"].should == "View Report"
  end
   actual_response["response_map"]["0"]["text"].should == "Home"
   actual_response["response_map"]["0"]["url"].should  == "sen/users/#{user_id}"
  steps %{
		Then the JSON at "session_id" should be "session id"
		Then the JSON at "session_type" should be "SESSION"
		Then the JSON should have "access_token"
    		}
end


Then /^User should see the "Next" option on tests list$/ do
	user_id = CanvasUserInterface.get_user_id
	course_id = CanvasCourseInterface.get_course_id
	actual_response = @last_response.parsed_response
	actual_response["response_map"]["#"]["url"].should  == "sen/users/#{user_id}/courses/#{course_id}/quizzes/?page=2"
	actual_response["response_map"]["#"]["text"].should  == "Next"
end

Then /^User should see the "Previous" option on tests list$/ do
	user_id = CanvasUserInterface.get_user_id
	course_id = CanvasCourseInterface.get_course_id
	actual_response = @last_response.parsed_response
	actual_response["response_map"]["*"]["url"].should  == "sen/users/#{user_id}/courses/#{course_id}/quizzes/?page=1"
	actual_response["response_map"]["*"]["text"].should  == "Previous"
end

When /^User replies "0" from tests page to go back to home page$/ do
	user_id = CanvasUserInterface.get_user_id
	body = @last_response.parsed_response.merge!({"message" => "0"})
	@last_response = JSONSpecInterface.post("#{SEN_URL}",
       	:body =>body.to_json,
	:headers => { "Content-Type" => "application/json"})
end

Given /^the following test data exists:$/ do |test_table|
  test_table.hashes.each do |hash|
    user = hash[:USER]
    role = hash[:ROLE]
    course = hash[:COURSE]
    tests = hash[:TESTS]
    
    steps %{
       Given the following users exists in canvas:
        |USER|
        |#{user}| 
       Given the following courses exist in canvas
        |COURSE|
        |#{course}|
    }
    steps %{
      And User navigates to quiz page and creates the following:
      |USER|COURSE|TESTS|
      |#{user}|#{course}|#{tests}|
      And User logs out      
    }
    steps %{
       When User is enrolled to the following courses:
          |COURSE|ROLE|
          |#{course}|#{role}|
    }
  end
end




