After do 
  p "teardown"
        user = CanvasUserInterface.get_user
        CanvasUserInterface.delete_user(user)
    end