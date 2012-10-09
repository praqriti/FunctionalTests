class Users
  attr_reader :name , :login_id , :password
  def initialize(user)
    @user = user
    @name = create_unique_name(user)
    @login_id = create_unique_login(user)
    @password = "password"
  end
  
  def create_unique_login(user)  
    date = Date.new
    time = Time.new
    login_id = "test_login"+"#{date}-"+"#{time.sec}"  
    return login_id
  end
  
  def create_unique_name(user)  
    date = Date.new
    time = Time.new
    name = "test_name"+"#{date}-"+"#{time.sec}"  
    return login_id
  end
  
end

# World(Users)
