Given /^User chooses the option "Connections"$/ do
  steps %{
     Then User replies with option "3"
   }
end

Then /^User should see the connections menu with (.*?) connections and (.*?) requests$/ do |connections, requests|
  steps %{
    Then the JSON at "message" should be "#{@messages.get("connection_menu", [connections, requests])}"
    Then the JSON at "session_id" should be "#{@session_id}"
    Then the JSON at "session_type" should be "SESSION"

  }

end


