require 'httparty'
require 'json_spec/cucumber'
require 'rubygems'

class ConnectionsInterface

  def self.create_connection(user, friend)
    connection_id = send_connection_request(friend, user)
    response = JSONSpecInterface.put( "#{CANVAS_URL}/sen/users/#{user.id}/connections/#{connection_id}",
                                       :body => {},
                                       :headers => { "Authorization" => "#{user.token}"})
    response["connection_state"].should == "connected"
  end

  def self.send_connection_request(user, friend)
    response = JSONSpecInterface.post("#{CANVAS_URL}/sen/users/#{user.id}/connections",
                                      :body => {:friend_id => friend.id},
                                      :headers => {"Authorization" => "#{user.token}"})
    connection_id = response["id"]
    connection_id.should_not == nil
    connection_id
  end

end

# World(CanvasUserInterface)
