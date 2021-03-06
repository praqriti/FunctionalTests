class CanvasCourseInterface

	def self.create_course(course, publish=true)
		@course = Course.new(course)
    body = {
        :course =>
            {
                :name => "#{@course.name}"
            }
    }
    body.merge!(:offer => true) if publish

		@last_response =
			JSONSpecInterface.post("#{CANVAS_API}/accounts/#{ACCOUNT_ID}/courses",
			:body =>  body,
			:headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
		JSONSpecInterface.raise_error(@last_response)
		@course.id =  @last_response.parsed_response["id"]
    sleep(2)
		return @course
	end 

	def self.delete_course(course)
		@delete_response = JSONSpecInterface.delete("#{CANVAS_API}/courses/#{course.id}",
		:body => {
			:event => "delete"
			},
		:headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
    JSONSpecInterface.raise_error(@last_response)
	end		   
end    
