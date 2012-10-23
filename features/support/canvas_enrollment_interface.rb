class CanvasEnrollmentInterface

	def self.enroll_user(course_id, user_id)
		@last_response =
			JSONSpecInterface.post("#{CANVAS_API}/courses/#{course_id}/enrollments",
			:body =>  {
			  :enrollment =>
				  {
				    :user_id => user_id,
				    :type => "TeacherEnrollment"
				  }
				  },
			:headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
		if (@last_response.response.code==200)
		    	 p "User Enrolled"
		end
	end
end
