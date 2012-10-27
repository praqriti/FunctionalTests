Before do 
  @users = Array.new
  @users << CanvasUserInterface.create_user("camfed_student")
end

After do 
  # CanvasUserInterface.delete_user(DEFAULT_USER)
  
  if (@users)
    @users.each do |user|      
       CanvasUserInterface.delete_user(user)
      end
  end
  
  if (@courses)
     @courses.each do |course|      
         CanvasCourseInterface.delete_course(course)
         p "#{course.name} deleted"
        end
  end
  
  if (@dummy_users)
    @users.each do |user|      
       CanvasUserInterface.delete_user(user)
      end
  end
end

  