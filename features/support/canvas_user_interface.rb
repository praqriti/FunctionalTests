require 'httparty'
require 'json_spec/cucumber'
require 'rubygems'

class CanvasUserInterface
    
  def self.create_user(user) 
    @user = Users.new(user)    
     @last_response =
        JSONSpecInterface.post("#{CANVAS_API}/accounts/#{ACCOUNT_ID}/users",
        :body =>  {
          :pseudonym =>
                  {
                    :unique_id => "#{@user.login_id}",
                    :password => "#{@user.password}"
                  },
          :user =>
                  {
                    :name => "#{@user.name}",
                    # :short_name => "#{user}"
                  }
                  },
        :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})         
      # end
      @user.id = @last_response.parsed_response["id"]
      p @user.id
end


def self.delete_user()
  p @user.login_id
        @delete_response = JSONSpecInterface.delete("#{CANVAS_API}/accounts/#{ACCOUNT_ID}/users/#{@user.id}",
        :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
        p "user deleted"
end

# def self.find_user(login_id)
#   @users_exist=false
#      @users_list = JSONSpecInterface.get("#{CANVAS_API}/accounts/#{ACCOUNT_ID}/users",
#      :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
#      if (@users_list.parsed_response.find(user["login_id"]==login_id))
#           @user_exists=true 
#             return user
#       end
# end

 def self.get_user_id
    return @user.id
  end
  
  def self.get_user
      return @user
    end

end

# World(CanvasUserInterface)

#handle failure