Given /^the following users exists in canvas:$/ do |users_table|
  @users = Array.new
    users_table.hashes.each do |hash|  
      @users << CanvasUserInterface.create_user("#{hash["USER"]}")
    end
end

Then /^the created users are deleted from canvas$/ do
  @users.each do |user|      
    CanvasUserInterface.delete_user(user)
   end  
end

