class Users
  attr_accessor :name , :login_id , :password, :id, :identifier
  def initialize(user)
    @identifier = user
    @name = create_unique_name(user)
    @login_id = create_unique_login(user)
    @password = create_unique_password(user)
  end
  
  def create_unique_login(user)  
    login_id = "test_login"+"#{1 + rand(10000000)}"  
    return login_id
  end
  
  def create_unique_name(user)  
     name = "#{user}"+"#{1 + rand(10000000)}"  
     return name
   end
   
   def create_unique_password(user)  
       password = "password"+"#{1 + rand(10000000)}"  
       return password
     end
  
end

