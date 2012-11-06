class CanvasCourseInterface

	def self.create_course(course)
		@course = Course.new(course)
		@last_response =
			JSONSpecInterface.post("#{CANVAS_API}/accounts/#{ACCOUNT_ID}/courses",
			:body =>  {
			  :course =>
				  {
				    :name => "#{@course.name}"
				  }, :offer => true
				  },
			:headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
		@course.id =  @last_response.parsed_response["id"]
		if (@last_response.response.code=="200")
  			p "course #{@course.name} created"
		end
		return @course
	end 

	def self.get_course_id
     		return @course.id
   	end

	def self.delete_course(course)
		@delete_response = JSONSpecInterface.delete("#{CANVAS_API}/courses/#{course.id}",
		:body => {
			:event => "delete"
			},
		:headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
	end		   
end    
