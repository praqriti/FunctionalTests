class CanvasEnrollmentInterface

	def self.enroll_user(course_id, user_id, enroll_type)
		@last_response =
			JSONSpecInterface.post("#{CANVAS_API}/courses/#{course_id}/enrollments",
			:body =>  {
			  :enrollment =>
				  {
				    :user_id => user_id,
				    :type => enroll_type,
            :enrollment_state => "active"
				  }
				  },
			:headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
		if (@last_response.response.code==200)
		    	 p "User Enrolled"
		end
	end
end
