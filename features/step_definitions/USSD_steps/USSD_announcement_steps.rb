And /^"(.*?)" has announcement "(.*?)" made by "(.*?)"$/ do |group_name, announcement, user_identifier|
  group = @groups.find{|group| group.name == group_name}
  user = @users.find{|u| u.identifier == user_identifier}
  Announcement.create user, group, :title => announcement, :message => announcement
end

Given /^User chooses to view announcements$/ do
  steps %{
   Then User replies with option "2"
 }
end

Then /^User should see announcement "(.*?)" made by "(.*?)"$/ do |announcement, user_identifier|
  user = @users.find{|u| u.identifier == user_identifier}
  body = @last_response.parsed_response
  body["message"].include?("#{user.name.truncate 15}: #{announcement.truncate 40}").should == true
end
