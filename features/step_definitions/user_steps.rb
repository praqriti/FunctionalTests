Given /^the following users exists in canvas:$/ do |users_table|
    users_table.hashes.each do |hash|  
      @users << User.create("#{hash["USER"]}")
    end
end

And /^"(.*?)" has his status set to "(.*?)"$/ do |user_identifier, status|
  user = @users.find{|user1| user1.identifier = user_identifier}
  @status = Status.create(:message => status, :user => user)
  @statuses_to_clean << @status
end


