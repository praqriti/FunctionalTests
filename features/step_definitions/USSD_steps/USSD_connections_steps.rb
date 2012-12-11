Given /^User chooses the option "Connections"$/ do
  steps %{
     Then User replies with option "3"
   }
end

Then /^User should see the connections menu$/ do
  steps %{
    Then the JSON at "message" should be "#{@messages.get("connection_menu")}"
    Then the JSON at "session_id" should be "session id"
    Then the JSON at "session_type" should be "SESSION"
    Then the JSON should have "access_token"
  }

end

When /^User replies "0" from connections page to go back to home page$/ do
  steps %{
      Then User replies with option "0"   
    }
end


