Given /^User chooses the option "Courses"$/ do
	user_id = CanvasUserInterface.get_user_id
	@last_response = JSONSpecInterface.post("#{SEN_URL}",
		:body =>{
			:session_id => "session id",
			:session_type => "SESSION",
			:message => "5",
			:access_token =>"#{@last_response.parsed_response["access_token"]}",
			:response_map =>
			{
				"5"=> {
				"text"=> "Courses",
				"url"=> "sen/users/#{user_id}/courses"
			  	},
				"4"=> {
				"text"=> "Groups",
				"url"=> "sen/users/#{user_id}/groups"
				},
				"3"=> {
				"text"=> "My Profile",
				"url"=> "sen/users/#{user_id}/profile"
				},
				"2"=> {
				"text"=> "Update Status",
				"url"=> "sen/users/#{user_id}/status"
				},
				"1"=> {
				"text"=> "Notifications",
				"url"=> "sen/users/#{user_id}/notifications"
				}
			}
		}.to_json,
	:headers => { "Content-Type" => "application/json"})
end

Given /^the following courses exist in canvas$/ do |courses_table|	
	@courses = Array.new	
	courses_table.hashes.each do |hash|
		@courses << CanvasCourseInterface.create_course("#{hash["COURSE"]}")
  end
end

And /^User is enrolled to the following courses$/ do |courses_table|	 
	@enrolled_courses = Array.new
	user_id = CanvasUserInterface.get_user_id
	courses_table.hashes.each do |hash|
		@courses.each do |course|
			if(course.name == "#{hash["COURSE"]}")
				CanvasEnrollmentInterface.enroll_user(course.id, user_id)
				@enrolled_courses << course
			end
		end
  end
end

Then /^User should see the courses list$/ do
	user_id = CanvasUserInterface.get_user_id
	actual_response = @last_response.parsed_response
	s_no = 1
	@enrolled_courses.each do |enrolled_course|
		actual_response["response_map"]["#{s_no}"]["text"].should == enrolled_course.name
		actual_response["response_map"]["#{s_no}"]["url"].should  == "/sen/users/#{user_id}/courses/#{enrolled_course.id}/quizzes"
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

Then /^the created courses are deleted$/ do
	@courses.each do |course|      
   		CanvasCourseInterface.delete_course(course)
   	end  
end
