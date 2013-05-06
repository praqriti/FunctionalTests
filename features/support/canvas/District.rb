class District
  attr_accessor :name, :id

  def initialize params
    @name = params["name"]
    @id = params["id"]
  end
end