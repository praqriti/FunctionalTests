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
    if (last_response.response.code !="200")
        p "Request failed at #{last_response.request.path.to_s} with error: #{last_response.to_json}"
    end
  end
end

World(JSONSpecInterface)


  # example usage
  # def self.find_by_zip(zip)
  #     get('/whoismyrep.php', :query => {:zip => zip})
  #   end
  # 
  #   def self.get_all_by_name(last_name)
  #     get('/getall_reps_byname.php', :query => {:lastname => last_name})
  #   end
  # end
  # 
  # puts Representative.get_all_by_name('Donnelly').inspect
  # # {"results"=>[{"district"=>"2", "last"=>"Donnelly", "xfirst"=>"Joe", "state"=>"IN", "party"=>"D"}]}