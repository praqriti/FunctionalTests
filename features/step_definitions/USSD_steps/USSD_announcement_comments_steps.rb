Given /^Group "(.*?)" with announcement "(.*?)" has "(.*?)" new comments made by "(.*?)"$/ do |group_name,announcement_name,comment_number,user_identifier,comments_table|
  steps %{
    Given User "#{user_identifier}" is enrolled with following groups:
     |name            |
     |#{group_name}   |
  }
  
  group = @groups.find{|group| group.name == group_name}
  user = @users.find{|u| u.identifier == user_identifier}
  announcement = @announcements.find{|ann| ann.title == announcement_name}
  comments_table.hashes.each do |hash|
    @announcement_comments << AnnouncementComment.create(user, group, announcement, :message => hash["COMMENTS"])
  end
end



