Before do 
  DEFAULT_USER = CanvasUserInterface.create_user("camfed_student")
end

After do 
  CanvasUserInterface.delete_user(DEFAULT_USER)
end

  