Then /^User should see the message "([^\"]*)"$/ do |message|
	user = CanvasUserInterface.get_user
	steps %{
	Then the JSON at "message" should be "#{message}"
	Then the JSON at "session_id" should be "session id"   
	Then the JSON at "session_type" should be "SESSION"
	Then the JSON should have "access_token"
	}
end

And /^User is enrolled to "([^\"]*)" as "([^\"]*)" with pending invitation$/ do |course_name, enroll_type|
	user_id = CanvasUserInterface.get_user_id
	@courses.each do |course|
		if(course.name == course_name)
			CanvasEnrollmentInterface.enroll_user(course.id, user_id, "#{enroll_type}Enrollment", "invited")
			@enrolled_courses << course
		end
	end
end
