require 'httparty'
require 'json_spec/cucumber'
require 'rubygems'

class UserStatusInterface
  def self.create_status user, message
    response = JSONSpecInterface.post( "#{CANVAS_URL}/sen/users/#{user.id}/status.json",
                            :body => { :status => {:message => message}},
                            :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
    response["message"].should == message
    sleep(1)
  end
end