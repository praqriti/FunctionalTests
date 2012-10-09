require 'httparty'
require 'json_spec/cucumber'
require 'rubygems'

class CanvasUserInterface
    
  def self.create_user(user) 
    @user = Users.new(user)    
    # for i in (0..400).step(1)
     @last_response =
        JSONSpecInterface.post("#{CANVAS_API}/accounts/#{ACCOUNT_ID}/users",
        :body =>  {
          :pseudonym =>
                  {
                    :unique_id => "#{@user.login_id}",
                    :password => "#{@user.password}"
                  },
                  },
        :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})         
      # end
end


def self.delete_user(user)
  user = CanvasUserInterface.get_user
  user = CanvasUserInterface.find_user(user.login_id)
  if(@user_exists)
        @delete_response = JSONSpecInterface.delete("#{CANVAS_API}/accounts/#{ACCOUNT_ID}/users/#{user["id"]}",
        :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
        p "user deleted"
      end
end

def self.find_user(login_id)
  @users_exist=false
     @users_list = JSONSpecInterface.get("#{CANVAS_API}/accounts/#{ACCOUNT_ID}/users",
     :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
     @users_list.parsed_response.each do |user|
        if(user["name"]==login_id)
          @user_exists=true 
            return user
        end
      end
end

 def self.get_user
    return @user
  end

end

# World(CanvasUserInterface)

#handle failure