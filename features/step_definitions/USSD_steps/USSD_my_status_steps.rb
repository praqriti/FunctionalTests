Then /^User should see the USSD my status page$/ do
   expected_message = @messages.get("my_status_page")
   @last_response.parsed_response["message"].include?(expected_message).should be_true
   steps %{
      Then the JSON at "session_type" should be "SESSION"
    }
end
