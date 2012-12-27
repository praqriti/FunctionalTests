And /^Group "(.*?)" has "(.*?)" new announcements made by "(.*?)":$/ do |group_name,announcement_number,user_identifier,announcements_table|
  group = @groups.find{|group| group.name == group_name}
  user = @users.find{|u| u.identifier == user_identifier}
announcements_table.hashes.each do |hash|
  Announcement.create user, group, :title => hash[:ANNOUNCEMENTS], :message => hash[:ANNOUNCEMENTS]
end
end

And /^Group "(.*?)" has "(.*?)" new announcements made by "(.*?)"$/ do |group_name,announcement_number,user_identifier|
  group = @groups.find{|group| group.name == group_name}
  user = @users.find{|u| u.identifier == user_identifier}
announcement_number.to_i.times do |hash|
  @announcements << 
  Announcement.create(user, group, AnnouncementData.announcement)
end
end

Then /^User should see "(.*?)" ordered announcements on page "(.*?)"$/ do |no_of_announcements,page_no|
  
end


Given /^User chooses to view announcements$/ do
  steps %{
   Then User replies with option "2"
 }
end

Given /^User chooses to make announcements$/ do
  steps %{
   Then User replies with option "1"
 }
end

Then /^User should see announcement "(.*?)" made by "(.*?)"$/ do |announcement, user_identifier|
  user = @users.find{|u| u.identifier == user_identifier}
  body = @last_response.parsed_response
  body["message"].include?("#{user.name.truncate 15}: #{announcement.truncate 40}").should == true
end

And /^User enters "([^\"]*)"$/ do |option|
  steps %{
     Then User replies with option "#{option}"
   }
end

And /^User chooses "Skip to Groups" option$/ do
  steps %{
     Then User replies with option "#"
   }
end

Then /^User should see confirmation for announcement created$/ do
  body = @last_response.parsed_response
  body["message"].include?("Announcement created").should == true
end

Then /^User is asked to "Enter Title of Announcement"$/ do
  body = @last_response.parsed_response
  body["message"].include?("Enter Title of Announcement").should == true
end

Then /^User is asked to "Enter the edit body of announcement or continue"$/ do
  body = @last_response.parsed_response
  body["message"].include?("Announcement created with body same as title.").should == true
  sleep(4)
end



