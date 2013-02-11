Given /^User chooses the option "Connections"$/ do
  steps %{
     Then User replies with option "3"
   }
end

Then /^User should see the connections menu$/ do
  steps %{
    Then the JSON at "message" should be "#{@messages.get("connection_menu")}"
    Then the JSON at "session_id" should be "#{@session_id}"
    Then the JSON at "session_type" should be "SESSION"

  }

end


