require 'httparty'
require 'json_spec/cucumber'
require 'rubygems'

class CanvasUserInterface

def self.delete_user(user)
        @delete_response = JSONSpecInterface.delete("#{CANVAS_API}/accounts/#{ACCOUNT_ID}/users/#{user.id}",
        :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
        JSONSpecInterface.raise_error(@delete_response)
end

def self.assign_account_admin(user)
  @last_response = JSONSpecInterface.post("#{CANVAS_API}/accounts/#{ACCOUNT_ID}/admins",
         :body => {
                   :user_id => "#{user.id}",
                  },
         :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
     JSONSpecInterface.raise_error(@last_response)
end

end

# World(CanvasUserInterface)
