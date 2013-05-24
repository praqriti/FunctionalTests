require 'httparty'
require 'json_spec/cucumber'
require 'rubygems'

class ConnectionsInterface

  def self.create_connection(user, friend)
    connection_id = send_connection_request(friend, user)
    response = JSONSpecInterface.put( "#{SEN_SOCIAL_URL}/connections/#{connection_id}",
                                       :body => {:sub_action => "accept"},
                                       :headers => { "Authorization" => "#{user.token}"})
    response["connection_state"].should == "accepted"
    sleep(4)
  end

  def self.send_connection_request(user, friend)
    response = JSONSpecInterface.post("#{SEN_SOCIAL_URL}/connections",
                                      :body => {:friend_id => friend.id},
                                      :headers => {"Authorization" => "#{user.token}"})
    connection_id = response["id"]
    connection_id.should_not == nil
    connection_id
  end

end

# World(CanvasUserInterface)
