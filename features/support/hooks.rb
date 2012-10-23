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
end

  