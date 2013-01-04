Given /^User chooses the option "Notifications"$/ do
  sleep 10
  steps %{
     Then User replies with option "1"   
   }
end

Then /^User should see the notifications menu$/ do
  steps %{
    Then the JSON at "session_id" should be "session id"
    Then the JSON at "session_type" should be "SESSION"
    Then the JSON should have "access_token"
  }

end

When /^User replies "0" from notifications page to go back to home page$/ do
  steps %{
      Then User replies with option "0"   
    }
end

Then /^User should see the notifications menu with blank notifications$/ do
  steps %{
   Then the JSON at "message" should be "There are no Notifications\\n0. Home"
  }
end

Then /^User should see the notifications menu with "(.*?)"$/ do |notification|
  @last_response.parsed_response["message"].include?(notification).should be_true
end


When /^User chooses the notification "(.*?)"$/ do |notification_name|
  message = @last_response.parsed_response["message"]
  notification_no, _ = message.match(/(\d+)\. #{notification_name}/i)
  steps %{
     Then User replies with option "#{notification_no[1]}"
   }
end

And /^"(.*?)" should see connection notification for "(.*?)"$/ do |user1, user2|
  user =  @users.find{|u| u.identifier == user1}
  friend = @users.find{|u| u.identifier == user2}
  msg = "1. #{friend.name} and #{user.name} are now connected".truncate(58)
  steps %{
    And User should see the notifications menu with "#{msg}"
  }
end

And /^"(.*?)" should see connection notification for user "(.*?)" with page_no "(.*?)"$/ do |user1, user2, page_no|
  page_no ||= 1
  user =  @users.find{|u| u.identifier == user1}
  friend = @users.find{|u| u.identifier == user2}
  msg = "#{page_no}. #{friend.name} and #{user.name} are now connected".truncate(58)
  steps %{
    And User should see the notifications menu with "#{msg}"
  }
end


