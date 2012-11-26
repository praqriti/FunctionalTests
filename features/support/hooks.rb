Before do 
  @users = Array.new
  @enrolled_courses = Array.new
	@courses = Array.new	
  @messages = Messages.new
  @errors = Errors.new
  @statuses_to_clean = []
  @logged_in_user = CanvasUserInterface.create_user("camfed_user")
  @users << @logged_in_user
end

After do   
  if (@users)
    @users.each do |user|      
       CanvasUserInterface.delete_user(user)
      end
  end
  
  if (@courses)
     @courses.each do |course|      
         CanvasCourseInterface.delete_course(course)
        end
  end
  
  if (@dummy_users)
    @users.each do |user|      
       CanvasUserInterface.delete_user(user)
      end
  end
end

  
