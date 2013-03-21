Given /^User has "(.*?)" new assignments$/ do |course_count|
  for i in 1..course_count.to_i
  test_name = "camfed_test_"+"#{i}"
   steps %{
    Given the following test data with questions exists:
    |ROLE   |COURSE  |STATUS  |TEST  |ATTEMPTS|QUESTIONS|
    |Teacher |test_course|active|#{test_name}|1|0|
          }    
   end
end

Given /^User has "(.*?)" new group announcement notifications$/ do |announcement_count|
  steps %{
  Given Group "camfed_group" has "#{announcement_count}" new announcements made by "camfed_user"  
  }
end

Given /^User has "(.*?)" new course announcement notifications$/ do |announcement_count|
  steps %{
  Given Course "camfed_course" has "#{announcement_count}" new announcements made by "camfed_user"  
  }
end


Given /^User has "(.*?)" accepted connection requests$/ do |connections|
  for i in 1..connections.to_i  
  friend = "camfed_friend_"+"#{i}"
  steps %{
    Given the following users exists in canvas:
    |USER|
    |#{friend}|
    And "camfed_user" has accepted connection request from "#{friend}"
  }
end
end


Then /^User should see comment notifications:$/ do |comments_table|  
  comments_table.hashes.each do |hash|
   user_by = @users.find{|u| u.identifier == hash["COMMENTED_BY"]}
   user_to = @users.find{|u| u.identifier == hash["COMMENTED_TO"]}
   
   recieved_message = @last_response.parsed_response["message"]
   actual_comment = "#{user_by.name} commented on #{user_to.name}".truncate(55)
   
   recieved_message.include?(actual_comment).should == true
   
   if (recieved_message.include?("Next"))
   steps %{
     When User chooses the "Next" option
    }
   end
 end
end

Given /^User has "(.*?)" status notifications$/ do |number_of_statuses|
  steps %{
     Given the following users exists in canvas:
       |USER|
       |camfed_friend|
     And "camfed_friend" has accepted connection request from "camfed_user"
   }
  for i in 1..number_of_statuses.to_i  
    steps %{
      And "camfed_friend" has his status set to "status_update_#{i}"
    }
end
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


Then /^User should see the notifications menu with blank notifications$/ do
  steps %{
   Then the JSON at "message" should be "No notifications available\\n0 Previous Menu"
  }
end

Then /^User should see the notifications menu with "(.*?)"$/ do |notification|
  p notification
  if (!@last_response.parsed_response["message"].include?(notification))
    raise "notification mismatch: #{@last_response.parsed_response["message"]}"
  end    
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

Then /^User should see connection notifications on USSD:$/ do |connections_table|
  connections_table.hashes.each do |hash|
   requesting_friend =  @users.find{|u| u.identifier == "#{hash["REQUESTING_FRIEND"]}"}
   accepting_friend = @users.find{|u| u.identifier == "#{hash["ACCEPTING_FRIEND"]}"}
   msg = "#{requesting_friend.name} and #{accepting_friend.name} are now connected".truncate(55)
   steps %{
     Then User should see the notifications menu with "#{msg}"
     When User chooses the "Next" option
   }
  end
end

Then /^User should see announcement notification "(.*?)" made by "(.*?)"$/ do |announcement, user_identifier|
  user = @users.find{|u| u.identifier == user_identifier}
  body = @last_response.parsed_response
  body["message"].include?("#{announcement.truncate 55}").should == true
end


