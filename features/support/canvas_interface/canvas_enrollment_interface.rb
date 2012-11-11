class CanvasEnrollmentInterface

	def self.enroll_user(course_id, user_id, enroll_type, state)
		@last_response =
			JSONSpecInterface.post("#{CANVAS_API}/courses/#{course_id}/enrollments",
			:body =>  {
			  :enrollment =>
				  {
				    :user_id => user_id,
				    :type => enroll_type,
				    :enrollment_state => state,
				    :notify => "false"
				  }
				  },
			:headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
    JSONSpecInterface.log(@last_response)
	    	return @last_response.parsed_response["id"]
	end

	def self.conclude_enrollment(course_id, enrollment_id)
    		@last_response =
        		JSONSpecInterface.delete("#{CANVAS_API}/courses/#{course_id}/enrollments/#{enrollment_id}",
                        :body =>  {
                          :task => "delete"
                               },
                               :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
        JSONSpecInterface.log(@last_response)
  end

  def self.enroll_type type
    return type == "Teacher" ? "TeacherEnrollment" : "StudentEnrollment"
  end
end
