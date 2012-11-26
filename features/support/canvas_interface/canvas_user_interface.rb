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
                    #:sort_name => "#{user}"
                  }
                  },
        :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
    JSONSpecInterface.log(@last_response)
    @user.id =  @last_response.parsed_response["id"]
     retrieve_user_token(@user)
     return @user
  end

def self.retrieve_user_token(user)
  @last_response = JSONSpecInterface.post("#{CANVAS_URL}/login",
      :body => {
        :pseudonym_session =>
            {
                :unique_id => "#{user.login_id}",
                :password => "#{user.password}"
            },
        :dev_key => "#{DEV_KEY}"
      },
      :headers => { "Accept" => "application/json"})
  JSONSpecInterface.log(@last_response)
  user.token = @last_response.parsed_response["token"]
end


def self.delete_user(user)
        @delete_response = JSONSpecInterface.delete("#{CANVAS_API}/accounts/#{ACCOUNT_ID}/users/#{user.id}",
        :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
        JSONSpecInterface.log(@delete_response)
end

def self.assign_account_admin(user)
  # @last_response = JSONSpecInterface.post("#{CANVAS_URL}/login",
  #       :body => {
  #         :pseudonym_session =>
  #             {
  #                 :unique_id => "#{user.login_id}",
  #                 :password => "#{user.password}"
  #             },
  #         :dev_key => "#{DEV_KEY}"
  #       },
  #       :headers => { "Accept" => "application/json"})
  #   JSONSpecInterface.log(@last_response)
  #   user.token = @last_response.parsed_response["token"]    
end

# def self.delete_all_users()
#   for i in (400..500).step(1)
#         @delete_response = JSONSpecInterface.delete("#{CANVAS_API}/accounts/#{ACCOUNT_ID}/users/#{i}",
#         :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
#         JSONSpecInterface.log(@delete_response)
#       end
# end

end

# World(CanvasUserInterface)
