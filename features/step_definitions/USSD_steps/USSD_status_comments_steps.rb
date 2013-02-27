Then /^User should see comment "(.*?)" made by "(.*?)"$/ do |comment, user_identifier|
  user = @users.find{|u| u.identifier == user_identifier}
  body = @last_response.parsed_response
  body["message"].include?("#{user.name.truncate 15}: #{comment.truncate 40}").should == true
end