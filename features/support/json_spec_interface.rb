require 'httparty'
require 'json_spec/cucumber'
require 'rubygems'

module JSONSpecInterface
  
  include HTTParty
   format :json
  
  def last_json
    @last_response.body
  end

  def self.log last_response
    if (!last_response.response.kind_of? Net::HTTPSuccess)
        scenario.fail("Request failed at #{last_response.request.path.to_s} with error: #{last_response.to_json}")
    end
  end
end

World(JSONSpecInterface)
