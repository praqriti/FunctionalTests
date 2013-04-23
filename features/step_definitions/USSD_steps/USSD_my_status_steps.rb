Then /^User should see the add comments menu option$/ do
  message = @messages.get("my_status_add_comment")
  @last_response.parsed_response["message"].include?(message).should be_true
end

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

And /^User has no comments on his status$/ do
  expected_message = @messages.get("zero_comments")
  @last_response.parsed_response["message"].include?(expected_message).should be_true
  steps %{
      Then the JSON at "session_type" should be "SESSION"
    }
end

When /^User chooses the option to view "comments on the status"$/ do
  steps %{
      Then User replies with option "3"
    }

end

Then /^User should see no comments message$/ do
  expected_message = @messages.get("no_comments_msg")
  @last_response.parsed_response["message"].include?(expected_message).should be_true
  steps %{
      Then the JSON at "session_type" should be "SESSION"
    }
end