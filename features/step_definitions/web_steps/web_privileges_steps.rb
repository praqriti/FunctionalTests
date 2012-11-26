When /^User tries to view the connections for user "(.*?)"$/ do |username|
  user = @users.find { |user| user.identifier == username}
  connections_page_url = "/users/#{user.id}/connections"
  visit connections_page_url
  steps %{
    Then User is given page not found error
  }
end

When /^User tries to update status for "(.*?)" as "(.*?)"$/ do |username, status|
  user = @users.find { |user| user.identifier == username}
  status_page_url = "/users/#{user.id}/status/new"
  visit status_page_url
end

Then /^User is given page not found error$/ do 
  error = @errors.get("page_not_found")
  page.should have_css('h2', :text => error)  
end

When /^User tries to view posts for user "(.*?)"$/ do |username|
  user = @users.find { |user| user.identifier == username}
end
