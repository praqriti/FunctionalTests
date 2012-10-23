class Users
  attr_accessor :name , :login_id , :password, :id, :user
  def initialize(user)
    @user = user
    @name = user
    @login_id = create_unique_login(user)
    @password = "password"
  end
  
  def create_unique_login(user)  
    time = Time.now.to_i
    login_id = "test_login"+"#{1 + rand(10000000)}"  
    return login_id
  end
  
end

