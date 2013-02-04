Given /^User has "(.*?)" new course invitations$/ do |course_count|
  for i in 1..course_count.to_i
  course_name = "camfed_course_"+"#{i}"
  steps %{
    Given User "camfed_user" is enrolled with following courses:
     |COURSE              |ROLE    |STATUS|
     |#{course_name}      |Student |active|
     }
     
   end
end

Given /^User "(.*?)" has "(.*?)" accepted connection requests$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Given /^User "(.*?)" has "(.*?)" announcements on groups$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Given /^User "(.*?)" has "(.*?)" announcements on courses$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Given /^User "(.*?)" has "(.*?)" status update notifications$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end



Given /^User chooses the option "Notifications"$/ do
  sleep 10
  steps %{
     Then User replies with option "1"   
   }
end

Then /^User should see the notifications menu$/ do
  steps %{
    Then the JSON at "session_id" should be "#{@session_id}"
    Then the JSON at "session_type" should be "SESSION"

  }

end

When /^User replies "0" from notifications page to go back to home page$/ do
  steps %{
      Then User replies with option "0"   
    }
end

Then /^User should see the notifications menu with blank notifications$/ do
  steps %{
   Then the JSON at "message" should be "There are no Notifications\\n0 Home"
  }
end

Then /^User should see the notifications menu with "(.*?)"$/ do |notification|
  @last_response.parsed_response["message"].include?(notification).should be_true
end

When /^User chooses the notification "(.*?)"$/ do |notification_name|
  message = @last_response.parsed_response["message"]
  notification_no, _ = message.match(/(\d+) #{notification_name}/i)
  steps %{
     Then User replies with option "#{notification_no[1]}"
   }
end

And /^"(.*?)" should see connection notification for "(.*?)"$/ do |user1, user2|
  user =  @users.find{|u| u.identifier == user1}
  friend = @users.find{|u| u.identifier == user2}
  msg = "#{friend.name} and #{user.name} are now connected".truncate(55)
  steps %{
    And User should see the notifications menu with "#{msg}"
  }
end

And /^"(.*?)" should see connection notification for user "(.*?)" with page_no "(.*?)"$/ do |user1, user2, page_no|
  page_no ||= 1
  user =  @users.find{|u| u.identifier == user1}
  friend = @users.find{|u| u.identifier == user2}
  msg = "#{friend.name} and #{user.name} are now connected".truncate(55)
  steps %{
    And User should see the notifications menu with "#{msg}"
  }
end


