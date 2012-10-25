Given /^User lands on the search page$/ do
  steps %{
  Then User navigates to search page
        }
  @app.search.wait_until_search_box_visible
  @app.search.all_there?
end

When /^User clicks on "search user" under connections tab$/ do
 page.find("#{@app.home.menu.connections}").trigger(:mouseover)
 # @app.home.menu.connections.search_users_link.click
end

When /^And User navigates to search page$/ do
 @app.search.load 
 @app.search.wait_until_search_box_visible
end

When /^User searches for "([^\"]*)" and clicks search$/ do |search_query|
  user = @users.find{|user| user.identifier == search_query}
  if (user)
  @app.search.search_box.set "#{user.name}" 
else
  @app.search.search_box.set "#{search_query}"
end
@app.search.search_button.click
end


When /^User adds the user "(.*?)" as a connection$/ do |username|
  user = @users.find{|user| user.identifier == username}
  @app.search.wait_until_search_results_visible
  # binding.pry
  @app.search.username.text.should == "#{user.name}"
  @app.search.unlinked_user.click
  @app.search.wait_until_connection_alert_visible
end

When /^User should see the users$/ do |users_table|
  @app.search.wait_until_search_results_visible
  users_table.hashes.each do |hash|  
  user = @users.find{|user| user.identifier == hash[:USER]}
  @app.search.username.text.should == "#{user.name}"
  end 
end

When /^User navigates to search page$/ do
  @app.search.load
end

When /^User should see the search error$/ do  
  @app.search.wait_until_search_error_visible
  @app.search.search_results.text.should == "Sorry!, Unable to find user with entered criteria"
end

Then /^User should see "(.*?)" as an "(.*?)" connection$/ do |identifier, connection_status|
  user = @users.find{|user| user.identifier == identifier}
    @app.search.wait_until_search_results_visible
    @app.search.username.text.should == "#{user.name}"
    @app.search.should have_unlinked_user if(connection_status == "unlinked")
    @app.search.should have_pending_request_user if(connection_status == "request pending")
    @app.search.should have_pending_response_user if(connection_status == "response pending")
end


Then /^User should see "(.*?)" without any connection status$/ do |username|
  user = @users.find{|user| user.identifier == username}
  @app.search.wait_until_search_results_visible
  @app.search.username.text.should == "#{user.name}"
      @app.search.should_not have_unlinked_user 
      @app.search.should_not have_pending_request_user 
      @app.search.should_not have_pending_response_user 
end







