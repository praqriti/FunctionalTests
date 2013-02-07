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

Given /^User "(.*?)" is enrolled with following unpublished courses:$/ do |username, courses_table|
  courses_table.hashes.each do |hash|
    @courses << CanvasCourseInterface.create_course("#{hash["COURSE"]}", false)
    enroll_type = "#{hash[:ROLE]}Enrollment"
    user = @users.find{|user| user.identifier == username}
    course = @courses.last
    CanvasEnrollmentInterface.enroll_user(course.id, user.id, enroll_type, hash[:STATUS])
  end
end

When /^User chooses the course "(.*?)"$/ do |course_name|
  course_no, _ = message.match(/(\d+) #{course_name}/i)
  steps %{
     Then User replies with option "#{course_no[1]}"
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
	user = @users.find{|user| user.identifier == username}
		@courses.each do |course|
			if(course.name == "#{hash[:COURSE]}")
				CanvasEnrollmentInterface.enroll_user(course.id, user.id, enroll_type, "active")
			@enrolled_courses << course
			end
		end
	end
end


Then /^User should see the courses list$/ do
	actual_response = @last_response.parsed_response
	s_no = 1
	@enrolled_courses.each do |enrolled_course|
    actual_response["message"].include?(enrolled_course.name).should == true
	s_no+=1
	end
	steps %{
		Then the JSON at "session_id" should be "#{@session_id}"
		Then the JSON at "session_type" should be "SESSION"

		}
		
		actual_response["message"].include?("0 Home").should == true
end

Then /^User should see the courses list in correct order$/ do
  @last_response["message"].include?("9 #{@enrolled_courses[8].name}\n10 #{@enrolled_courses[9].name}\n11 #{@enrolled_courses[10].name}").should == true
end

Then /^User should see the courses list on page "([^\"]*)"$/ do |page_no|
	actual_response = @last_response.parsed_response
	page_no = page_no.to_i
	rpp = "#{RECORDS_PER_PAGE}".to_i
	s_no = (rpp * (page_no-1)) + 1
	start_index = rpp * (page_no-1)
	end_index = start_index + (rpp-1)
	@enrolled_courses[start_index..end_index].each do |enrolled_course|
		actual_response["message"].include?(enrolled_course.name).should == true
	end
	steps %{
		Then the JSON at "session_id" should be "#{@session_id}"
		Then the JSON at "session_type" should be "SESSION"

		}
end

And /^User should not see "Previous" and "Next" option$/ do
	actual_response = @last_response.parsed_response
	actual_response["response"]["response_map"]["*"].should  be_nil
	actual_response["response"]["response_map"]["#"].should  be_nil
end

And /^User should see the "Next" and "Previous" option$/ do
	actual_response = @last_response.parsed_response["response"]
	actual_response["message"].include?("Previous").should == true
	actual_response["message"].include?("Next").should == true
end

And /^User should see the "([^\"]*)" option$/ do |option|
	actual_response = @last_response.parsed_response["response"]
  actual_response["message"].include?(option).should == true
end

Then /^User should only see course "([^\"]*)"$/ do |course_name|
  actual_response["message"].include?("1 #{course_name}").should == true
	steps %{
		Then the JSON at "session_id" should be "#{@session_id}"
		Then the JSON at "session_type" should be "SESSION"

		}
end

Then /^User should see home as the last option$/ do
  last_option = @last_response["message"].split("\n").last
  last_option.should == "0 Home"
end