class Country
  @@countries = nil
  attr_accessor :name, :id

  def initialize params
    @name = params["name"]
    @id = params["id"]
  end

  def self.all force=false
    return @@countries unless force || @@countries.nil?
    last_response = JSONSpecInterface.get("#{CANVAS_API}/countries",
        :headers => { "Accept" => "application/json", "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
    response = last_response.parsed_response
    response = response.class != Array ? [] : response
    @@countries = []
    response.each do |country|
      @@countries << new(country)
    end
    @@countries
  end

  def districts force=false
    return @districts unless force || @districts.nil?
    last_response = JSONSpecInterface.get("#{CANVAS_API}/countries/#{self.id}/districts",
                                           :headers => { "Accept" => "application/json",
                                                         "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
    response = last_response.parsed_response
    @districts = []
    response.each do |district|
      @districts << District.new(district)
    end
    @districts
  end
end