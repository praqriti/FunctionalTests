class Users
  attr_accessor :name , :login_id , :password, :id
  def initialize(user)
    @user = user
    @name = create_unique_name(user)
    @login_id = create_unique_login(user)
    @password = "password"
  end
  
  def create_unique_login(user)  
    time = Time.now.to_i
    login_id = "test_login"+"#{1 + rand(10000000)}"  
    p login_id
    return login_id
  end
  
  def create_unique_name(user)  
    time = Time.now.to_i
    name = "#{user}"+"#{time}"  
    return name
  end
  
end

# World(Users)
