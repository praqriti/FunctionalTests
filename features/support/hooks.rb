Before do 
  DEFAULT_USER = CanvasUserInterface.create_user("camfed_student")
end

After do 
  CanvasUserInterface.delete_user(DEFAULT_USER)
  
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
end

  