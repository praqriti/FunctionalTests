Given /^User chooses the option "Courses"$/ do
	body = @last_response.parsed_response
	body.merge!({"message" => "5"})
	@last_response = JSONSpecInterface.post("#{SEN_URL}",
		                           :body => body.to_json,
		                           :headers => { "Content-Type" => "application/json"})
end

Given /^User "(.*?)" is enrolled with following courses:$/ do |username, courses_table|
  courses_table.hashes.each do |hash|
		@courses << CanvasCourseInterface.create_course("#{hash["COURSE"]}")
		enroll_type = "#{hash[:ROLE]}Enrollment"
		user = @users.find{|user| user.identifier == username}
		course = @courses.last
  	CanvasEnrollmentInterface.enroll_user(course.id, user.id, enroll_type, hash[:STATUS])
  	@enrolled_courses << course
	end
end

When /^User chooses the course "(.*?)"$/ do |course_name|
	actual_response = @last_response.parsed_response
	course_no = actual_response["response"]["response_map"].find{|course| course[1]["text"] == course_name}.first
  body = actual_response
	body.merge!({"message" => "#{course_no}"})
	@last_response = JSONSpecInterface.post("#{SEN_URL}",
		                           :body => body.to_json,
		                           :headers => { "Content-Type" => "application/json"})
	
end


Given /^the following courses exist in canvas$/ do |courses_table|	
	courses_table.hashes.each do |hash|
		@courses << CanvasCourseInterface.create_course("#{hash["COURSE"]}")
	end
end


Given /^User is enrolled to the following courses:$/ do |enrollment_table|
  enrollment_table.hashes.each do |hash|
  enroll_type = "#{hash[:ROLE]}Enrollment"
	user_id = CanvasUserInterface.get_user_id
		@courses.each do |course|
			if(course.name == "#{hash[:COURSE]}")
				CanvasEnrollmentInterface.enroll_user(course.id, user_id, enroll_type, "active")
			@enrolled_courses << course
			end
		end
	end
end


Then /^User should see the courses list$/ do
	actual_response = @last_response.parsed_response
	s_no = 1
	@enrolled_courses.each do |enrolled_course|
		actual_response["response"]["response_map"]["#{s_no}"]["text"].should == enrolled_course.name
	s_no+=1
	end
	actual_response["response"]["response_map"]["0"]["text"].should == "Home"
	steps %{
		Then the JSON at "session_id" should be "session id"
		Then the JSON at "session_type" should be "SESSION"
		Then the JSON should have "access_token"
		}
end

Then /^User should see the courses list on page "([^\"]*)"$/ do |page_no|
	actual_response = @last_response.parsed_response
	page_no = page_no.to_i
	rpp = "#{RECORDS_PER_PAGE}".to_i
	s_no = (rpp * (page_no-1)) + 1
	start_index = rpp * (page_no-1)
	end_index = start_index + (rpp-1)
	@enrolled_courses[start_index..end_index].each do |enrolled_course|
		actual_response["response"]["response_map"]["#{s_no}"]["text"].should == enrolled_course.name
		s_no+=1
	end
	actual_response["response"]["response_map"]["0"]["text"].should == "Home"
	steps %{
		Then the JSON at "session_id" should be "session id"
		Then the JSON at "session_type" should be "SESSION"
		Then the JSON should have "access_token"
		}
end

And /^User should not see "Previous" and "Next" option$/ do
	actual_response = @last_response.parsed_response
	actual_response["response"]["response_map"]["*"].should  be_nil
	actual_response["response"]["response_map"]["#"].should  be_nil
end

And /^User chooses the "Next" option$/ do
	body = @last_response.parsed_response
	body.merge!({"message" => "#"})
	@last_response = JSONSpecInterface.post("#{SEN_URL}",
		                          :body => body.to_json,
		                          :headers => { "Content-Type" => "application/json"})
end

And /^User should see the "Next" option$/ do
	user_id = CanvasUserInterface.get_user_id
	actual_response = @last_response.parsed_response
	actual_response["response"]["response_map"]["#"]["url"].should  == "sen/users/#{user_id}/courses/?page=2"
	actual_response["response"]["response_map"]["#"]["text"].should  == "Next"
end

And /^User should see the "Next" and "Previous" option$/ do
	user_id = CanvasUserInterface.get_user_id
	actual_response = @last_response.parsed_response
	actual_response["response"]["response_map"]["*"]["url"].should == "sen/users/#{user_id}/courses/?page=1"
	actual_response["response"]["response_map"]["*"]["text"].should == "Previous"
	actual_response["response"]["response_map"]["#"]["url"].should  == "sen/users/#{user_id}/courses/?page=3"
	actual_response["response"]["response_map"]["#"]["text"].should  == "Next"
end

And /^User should see the "Previous" option$/ do
	user_id = CanvasUserInterface.get_user_id
	actual_response = @last_response.parsed_response
	actual_response["response"]["response_map"]["*"]["url"].should  == "sen/users/#{user_id}/courses/?page=2"
	actual_response["response"]["response_map"]["*"]["text"].should  == "Previous"
end

And /^User chooses the "Previous" option$/ do
	body = @last_response.parsed_response
	body.merge!({"message" => "*"})
	@last_response = JSONSpecInterface.post("#{SEN_URL}",
		                          :body => body.to_json,
		                          :headers => { "Content-Type" => "application/json"})
end

When /^User replies "0" to go back to home page$/ do
	body = @last_response.parsed_response.merge!({"message" => "0"})
	@last_response = JSONSpecInterface.post("#{SEN_URL}",
       	:body =>body.to_json,
	:headers => { "Content-Type" => "application/json"})
	@last_response.parsed_response["response"]["response_map"]["1"]["text"].should == "Notifications"
end

Then /^User should only see course "([^\"]*)"$/ do |course_name|
	@last_response.parsed_response["response"]["response_map"]["1"]["text"].should == course_name
	@last_response.parsed_response["response"]["response_map"]["0"]["text"].should == "Home"
	steps %{
		Then the JSON at "session_id" should be "session id"
		Then the JSON at "session_type" should be "SESSION"
		Then the JSON should have "access_token"
		}
end
