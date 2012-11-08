Given /^User chooses the option "Notifications"$/ do
  steps %{
     Then User replies with option "1"   
   }
end

Then /^User should see the notifications menu$/ do
  user_id = CanvasUserInterface.get_user_id
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



