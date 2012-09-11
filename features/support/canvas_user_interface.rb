require 'httparty'
require 'json_spec/cucumber'
require 'rubygems'

module CanvasUserInterface

  
  def self.create_user(login_id,password)
  delete_user(login_id)  
  
  @last_response =
     JSONSpecInterface.post("#{CANVAS_API}/accounts/#{ACCOUNT_ID}/users",
     :body =>  {:pseudonym =>
               {
                 :unique_id => "user_one",
                 :password => "password_one"
               }
               },
     :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"}).to_json
end


def self.delete_user(login_id)
  user = CanvasUserInterface.find_user(login_id)
  if(@user_exists)
        @delete_response = JSONSpecInterface.delete("#{CANVAS_API}/accounts/#{ACCOUNT_ID}/users/#{user["id"]}",
        :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
        p "user deleted"
  else
        p "could not delete user"
  end
end

def self.find_user(login_id)
     @users_list = JSONSpecInterface.get("#{CANVAS_API}/accounts/#{ACCOUNT_ID}/users",
     :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
     @users_list.parsed_response.each do |user|
        if(user["login_id"]==login_id)
          @user_exists=true 
            return user
            p user
        else
          @user_exists=false      
        end  
      end  
    end
    
end
World(CanvasUserInterface)

#handle failure