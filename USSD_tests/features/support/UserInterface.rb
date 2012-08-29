require 'httparty'
require 'json_spec/cucumber'
require 'rubygems'

module UserInterface

  @canvas_api_url= "http://localhost:3000"
  @account_id = USER["default"]["account_id"]
  @login_id = USER["default"]["login_id"]
  @user_id
  
  def self.create_user  
  @last_response =
  JSONSpecInterface.post("#{@canvas_api_url}/api/v1/accounts/#{@account_id}/users",
  :body => {  "user[name]" => "dummy",
              "pseudonym[unique_id]" => "#{@login_id}",
              "pseudonym[password]" => "password"                
              },
  :headers => { "Authorization" => "Bearer 7sebC7aEqJsX4wK5oUf11KLtY4fZxyBokkNowYOR4La62RjYiUL3q0MotvtZZxor"})
  @user_id = @last_response.parsed_response["id"]
  p "user created" if @last_response.code == 200
end

def self.delete_user
  
  @last_response = 
    JSONSpecInterface.delete("#{@canvas_api_url}/api/v1/accounts/#{@account_id}/users/#{@user_id}",
    :headers => { "Authorization" => "Bearer 7sebC7aEqJsX4wK5oUf11KLtY4fZxyBokkNowYOR4La62RjYiUL3q0MotvtZZxor"})
     p @user_id
     p "user with id: #{@user_id} deleted" if @last_response.code == 200
end

end
World(UserInterface)

#handle failure