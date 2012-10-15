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
     @user.id =  @last_response.parsed_response["id"]
     if (@last_response.response.code==200)
     p "user #{@user.login_id} created"
   end
     return @user      
end


def self.delete_user(user)
        @delete_response = JSONSpecInterface.delete("#{CANVAS_API}/accounts/#{ACCOUNT_ID}/users/#{user.id}",
        :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
        p "user #{user.login_id} deleted"
end

def self.delete_all_users()
  for i in (400..500).step(1)
        @delete_response = JSONSpecInterface.delete("#{CANVAS_API}/accounts/#{ACCOUNT_ID}/users/#{i}",
        :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
        p "#{@delete_response}"
      end
end

 def self.get_user_id
     return @user.id
   end
   
   def self.get_user
       return @user
     end
 
end

# World(CanvasUserInterface)
