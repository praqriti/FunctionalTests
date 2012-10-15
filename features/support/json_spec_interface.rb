require 'httparty'
require 'json_spec/cucumber'
require 'rubygems'

module JSONSpecInterface
  
  include HTTParty
   format :json
  
  def last_json
    @last_response.body
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