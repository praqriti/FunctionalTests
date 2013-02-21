Before do 
  @users = Array.new
  @enrolled_courses = Array.new
	@courses = Array.new	
	@groups = Array.new
  @messages = Messages.new
  @errors = Errors.new
  @announcements = Array.new
  @statuses_to_clean = []
  @requesters = []
  @quizzes = []
  @questions = []
  @connected_users = []
  @logged_in_user = User.create("camfed_user")
  @users << @logged_in_user
  @enrolled_groups = Array.new
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
   
    if (@groups)
       @groups.each do |group|
         group.delete
        end
    end
    
   if (@dummy_users)
       @users.each do |user|      
          CanvasUserInterface.delete_user(user)
         end
     end
end

  
