Then /^User should see the USSD resume page$/ do
  expected_message = @messages.get("resume_menu")
  steps %{
    Then the JSON at "message" should be "#{expected_message}"
    Then the JSON at "session_type" should be "SESSION"
    Then the JSON at "session_id" should be "#{@session_id}"
  }
end