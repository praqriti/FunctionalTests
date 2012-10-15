class App
  def home
    Home.new
  end

  def login
    Login.new
  end

  def search
    Search.new
  end
  
  def groups
    Groups.new
  end
  
  def course
    Courses.new
  end
  
  def my_wall
    Wall.new
  end

  def user_wall
    Wall.new
  end
  
  def redirect
    Redirect.new
  end 
end