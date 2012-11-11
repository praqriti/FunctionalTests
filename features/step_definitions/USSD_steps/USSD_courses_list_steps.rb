Given /^User chooses the option "Courses"$/ do
 steps %{
   Then User replies with option "5"
 }
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
	actual_response = @last_response.parsed_response["response"]
	course_no = actual_response["response_map"].find{|course| course[1]["text"] == course_name}.first
  
	steps %{
     Then User replies with option "#{course_no}"
   }
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
	steps %{
	  Then User replies with option "#"
	}
end

And /^User should see the "Next" option$/ do
	actual_response = @last_response.parsed_response["response"]
	actual_response["response_map"]["#"]["text"].should  == "Next"
end

And /^User should see the "Next" and "Previous" option$/ do
	actual_response = @last_response.parsed_response["response"]
	actual_response["response_map"]["*"]["text"].should == "Previous"
	actual_response["response_map"]["#"]["text"].should  == "Next"
end

And /^User should see the "Previous" option$/ do
	actual_response = @last_response.parsed_response["response"]
	actual_response["response_map"]["*"]["text"].should  == "Previous"
end

And /^User chooses the "Previous" option$/ do
 steps %{
   Then User replies with option "*"   
 }
end

When /^User replies "0" to go back to home page$/ do
  steps %{
    Then User replies with option "0"   
  }
  binding.pry
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
