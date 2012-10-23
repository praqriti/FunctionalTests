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
	@enrolled_courses.sort! { |c1, c2| c1.name <=> c2.name }
	steps %{
		Then the JSON at "session_id" should be "session id"
		Then the JSON at "session_type" should be "SESSION"
		Then the JSON should have "access_token"
		Then the JSON at "response_map" should be:
		"""
		{
			"2": {
			"text": "History",
			"url": "/sen/users/#{user_id}/courses/#{@enrolled_courses[1].id}/quizzes"
			},
			"1": {
			"text": "Chemistry",
			"url": "/sen/users/#{user_id}/courses/#{@enrolled_courses[0].id}/quizzes"
			},
			"0": {
			"text": "Home",
			"url": "sen/users/#{user_id}"
			}
		}
		"""
    		}
end

When /^User replies "0" from courses page to go back to home page$/ do
	user_id = CanvasUserInterface.get_user_id
	@last_response = JSONSpecInterface.post("#{SEN_URL}",
      	:body => {
		  :session_id => "session id",
		  :session_type => "SESSION",
		  :message => "0",
		  :access_token =>"#{@last_response.parsed_response["access_token"]}",
		  :response_map =>
		  {				
				"2"=> {
				"text"=>"History",
				"url"=>""
				},
				"1"=> {
				"text"=>"Chemistry",
				"url"=>""
				},
				"0"=> {
				"text"=>"Home",
				"url"=>"sen/users/#{user_id}"
				}
		  }
	}.to_json,
	:headers => { "Content-Type" => "application/json"})
end

Then /^the created courses are deleted$/ do
	@courses.each do |course|      
   		CanvasCourseInterface.delete_course(course)
   	end  
end
