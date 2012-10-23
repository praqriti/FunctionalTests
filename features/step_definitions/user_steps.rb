Given /^the following users exists in canvas:$/ do |users_table|
  @users = Array.new
    users_table.hashes.each do |hash|  
      @users << CanvasUserInterface.create_user("#{hash["USER"]}")
      p @users
    end
end


