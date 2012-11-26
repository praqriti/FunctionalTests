When /^User tries to view the connections for user "(.*?)"$/ do |username|
  user = @users.find { |user| user.identifier == username}
  connections_page_url = "/users/#{user.id}/connections"
  visit connections_page_url
  steps %{
    Then User is given page not found error
  }
end

Then /^User is given page not found error$/ do 
  error = @errors.get("page_not_found")
  page.should have_css('h2', :text => error)  
end


Then /^User should be able to see only his connection "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^User tries to view posts for user "(.*?)"$/ do |username|
  user = @users.find { |user| user.identifier == username}
end

Then /^User is given an authorisation error$/ do
  pending # express the regexp above with the code you wish you had
end

When /^"(.*?)" tries to view comments for user "(.*?)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end
