require 'httparty'
require 'json_spec/cucumber'
require 'rubygems'

module CanvasUserInterface

  @account_id = 1
  
  def self.create_user(login_id,password)
    
  delete_user(login_id)
  
  
  @last_response =
  JSONSpecInterface.post("#{CANVAS_API}/accounts/#{@account_id}/users",
  :body => {  "user[name]" => "username",
              "pseudonym[unique_id]" => "#{login_id}",
              "pseudonym[password]" => "#{password}"                
              },
  :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
end


def self.delete_user(login_id)
  user = CanvasUserInterface.find_user(login_id)
        JSONSpecInterface.delete("#{CANVAS_API}/accounts/#{@account_id}/users/#{user["id"]}",
        :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
end

def self.find_user(login_id)
     @users_list = JSONSpecInterface.get("#{CANVAS_API}/accounts/#{@account_id}/users",
     :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
     @users_list.parsed_response.each do |user|
        if(user["login_id"]==login_id)
            return user
        end  
      end  
    end
    
end
World(CanvasUserInterface)

#handle failure