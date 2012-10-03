require 'httparty'
require 'json_spec/cucumber'
require 'rubygems'

module CanvasUserInterface

  
  def self.create_user(login_id,password)
  # delete_user(login_id)  
    # for i in (0..400).step(1)
     @last_response =
        JSONSpecInterface.post("#{CANVAS_API}/accounts/#{ACCOUNT_ID}/users",
        :body =>  {:pseudonym =>
                  {
                    :unique_id => "#{login_id}",
                    :password => "#{password}"
                  }
                  },
        :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})         
      # end
end


def self.delete_user(login_id)
  user = CanvasUserInterface.find_user(login_id)
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
        if(user["login_id"]==login_id)
          @user_exists=true 
            return user
            p user
        end
      end
      end  
end

World(CanvasUserInterface)

#handle failure