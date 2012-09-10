require 'httparty'
require 'json_spec/cucumber'
require 'rubygems'

module CanvasUserInterface

  @account_id = 2
  @user_exists = false
  
  def self.create_user(login_id,password)
  delete_user(login_id)  
  
  @last_response =
  JSONSpecInterface.post("#{CANVAS_API}/accounts/#{@account_id}/users",
  :body =>  {:pseudonym =>
            {
              :unique_id => "#{login_id}",
              :password => "#{password}"
            }
            },
  :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"}).to_json
end


def self.delete_user(login_id)
  user = CanvasUserInterface.find_user(login_id)
  if(@user_exists)
        JSONSpecInterface.delete("#{CANVAS_API}/accounts/#{@account_id}/users/#{user["id"]}",
        :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
  end
end

def self.find_user(login_id)
     @users_list = JSONSpecInterface.get("#{CANVAS_API}/accounts/#{@account_id}/users",
     :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
     @users_list.parsed_response.each do |user|
        if(user["login_id"]==login_id)
          @user_exists =true
            return user
        end  
      end  
    end
    
end
World(CanvasUserInterface)

#handle failure