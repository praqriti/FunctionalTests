class User
  attr_accessor :name , :login_id , :password, :id, :identifier, :token, :country, :district, :location, :email
  def initialize(identifier, params = {})
    @identifier = identifier
    @name = create_unique_name(identifier)
    @login_id = create_unique_login
    @password = create_unique_password
    @email = params[:email]
    @country = params[:country]
    @district = params[:district]
    @location = params[:location]
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
    @token = @last_response.parsed_response["token"]
    return @token
  end

  def self.create identifier, others = {}
    user = new(identifier)
    user_hash = {
        :name => "#{user.name}",
        #:sort_name => "#{user}"
    }

    user_hash.merge!(others)
    @last_response =
        JSONSpecInterface.post("#{CANVAS_API}/accounts/#{ACCOUNT_ID}/users",
                               :body =>  {
                                   :pseudonym =>
                                       {
                                           :unique_id => "#{user.login_id}",
                                           :password => "#{user.password}"
                                       },
                                   :user => user_hash
                               },
                               :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
                               # p @last_response
    JSONSpecInterface.raise_error(@last_response)
    user.id =  @last_response.parsed_response["id"]
    return user
  end
  
  def create_unique_login
    login_id = "test_login"+"#{1 + rand(10000000)}" 
    return login_id
  end
  
  def create_unique_name(identifier)
     name = "#{identifier}"+"#{1 + rand(10000000)}"
     return name
   end
   
   def create_unique_password
       password = "password"+"#{1 + rand(10000000)}"  
       return password
   end
end
