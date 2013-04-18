Then /^User should see the view comments menu option with "([^\"]*)" comments$/ do |comment_count|
  message = "View Comments[#{comment_count}]"
  @last_response.parsed_response["message"].include?(message).should be_true
end

Then /^User should see the USSD my status page$/ do
   expected_message = @messages.get("my_status_page")
   @last_response.parsed_response["message"].include?(expected_message).should be_true
   steps %{
      Then the JSON at "session_type" should be "SESSION"
    }
end
