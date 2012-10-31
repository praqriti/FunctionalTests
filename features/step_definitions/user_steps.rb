Given /^the following users exists in canvas:$/ do |users_table|
    users_table.hashes.each do |hash|  
      @users << CanvasUserInterface.create_user("#{hash["USER"]}")
    end
end

And /^"(.*?)" has his status set to "(.*?)"$/ do |user_identifier, status|
  user = @users.find{|user1| user1.identifier = user_identifier}
  UserStatusInterface.create_status user, status
end


