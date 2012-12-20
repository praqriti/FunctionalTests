Given /^User chooses the option "Notifications"$/ do
  sleep 5
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
  @last_response.parsed_response["message"].include?( notification).should be_true
end


