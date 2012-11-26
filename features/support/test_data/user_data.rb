class Users
  attr_accessor :name , :login_id , :password, :id, :identifier, :token
  def initialize(user)
    @identifier = user
    @name = create_unique_name(user)
    @login_id = create_unique_login(user)
    @password = create_unique_password(user)
  end

  def token
    return @token if !@token.nil?
    @last_response = JSONSpecInterface.post("#{CANVAS_URL}/login",
                                            :body => {
                                                :pseudonym_session =>
                                                    {
                                                        :unique_id => "#{@login_id}",
                                                        :password => "#{@password}"
                                                    },
                                                :dev_key => "#{DEV_KEY}"
                                            },
                                            :headers => { "Accept" => "application/json"})
    JSONSpecInterface.log(@last_response)
    @token = @last_response.parsed_response["token"]
    return @token
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
