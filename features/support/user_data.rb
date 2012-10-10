class Users
  attr_reader :name , :login_id , :password
  def initialize(user)
    @user = user
    @name = create_unique_name(user)
    @login_id = create_unique_login(user)
    @password = "password"
  end
  
  def create_unique_login(user)  
    # date = Date.new
    time = Time.now.to_i
    login_id = "test_login"+"#{time}"  
    return login_id
  end
  
  def create_unique_name(user)  
    # date = Date.new
    time = Time.now.to_i
    name = "#{user}"+"#{time}"  
    return name
  end
  
end

# World(Users)
