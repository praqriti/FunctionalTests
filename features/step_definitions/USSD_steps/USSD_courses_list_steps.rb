Given /^User chooses the option "Courses"$/ do
  body = @last_response.parsed_response
   body.merge!({"message" => "5"})
   @last_response = JSONSpecInterface.post("#{SEN_URL}",
                                           :body => body.to_json,
                                           :headers => { "Content-Type" => "application/json"})
end

Given /^the following courses exist in canvas$/ do |courses_table|	
	@courses = Array.new	
	courses_table.hashes.each do |hash|
		@courses << CanvasCourseInterface.create_course("#{hash["COURSE"]}")
  end
end

And /^User is enrolled to the following courses as "([^\"]*)"$/ do |type, courses_table|
	@enrolled_courses = Array.new
  	enroll_type = type == "teacher" ? "TeacherEnrollment" : "StudentEnrollment"
	user_id = CanvasUserInterface.get_user_id
	courses_table.hashes.each do |hash|
		@courses.each do |course|
			if(course.name == "#{hash["COURSE"]}")
				CanvasEnrollmentInterface.enroll_user(course.id, user_id, enroll_type)
				@enrolled_courses << course
			end
		end
  end
end

Then /^User should see the courses list$/ do
  actual_response = @last_response.parsed_response
  s_no = 1
  @enrolled_courses[0..3].each do |enrolled_course|
    actual_response["response_map"]["#{s_no}"]["text"].should == enrolled_course.name
    s_no+=1
  end
  actual_response["response_map"]["0"]["text"].should == "Home"
  steps %{
		Then the JSON at "session_id" should be "session id"
		Then the JSON at "session_type" should be "SESSION"
		Then the JSON should have "access_token"
    		}
end

And /^User should not see "Previous" and "Next" option$/ do
  actual_response = @last_response.parsed_response
  actual_response["response_map"]["*"].should  be_nil
  actual_response["response_map"]["#"].should  be_nil
end

And /^User chooses the "Next" option$/ do
  body = @last_response.parsed_response
  body.merge!({"message" => "#"})
  @last_response = JSONSpecInterface.post("#{SEN_URL}",
                                          :body => body.to_json,
                                          :headers => { "Content-Type" => "application/json"})
end

And /^User should see the "Next" option on first page$/ do
  user_id = CanvasUserInterface.get_user_id
  actual_response = @last_response.parsed_response

  actual_response["response_map"]["#"]["url"].should  == "sen/users/#{user_id}/courses/?page=2"
  actual_response["response_map"]["#"]["text"].should  == "Next"
end

And /^User should see "Previous" and "Next" option$/ do
  user_id = CanvasUserInterface.get_user_id
  actual_response = @last_response.parsed_response
  actual_response["response_map"]["*"]["url"].should == "sen/users/#{@user_id}/courses/?page=1"
  actual_response["response_map"]["*"]["text"].should == "Previous"
  actual_response["response_map"]["#"]["url"].should  == "sen/users/#{user_id}/courses/?page=3"
  actual_response["response_map"]["#"]["text"].should  == "Next"
end

When /^User replies "0" from courses page to go back to home page$/ do
	user_id = CanvasUserInterface.get_user_id
	body = @last_response.parsed_response.merge!({"message" => "0"})
	@last_response = JSONSpecInterface.post("#{SEN_URL}",
       	:body =>body.to_json,
	:headers => { "Content-Type" => "application/json"})
end

Then /^"([^\"]*)" should be displayed to the User$/ do |message|
	user_id = CanvasUserInterface.get_user_id
	steps %{
		Then the JSON at "message" should be "#{message}"
		Then the JSON at "session_id" should be "session id"
		Then the JSON at "session_type" should be "SESSION"
		Then the JSON should have "access_token"
		Then the JSON at "response_map" should be:
		"""
		{
			"0": {
			"text": "Home",
			"url": "sen/users/#{user_id}"
			}
		}
		"""
    		}
end	

