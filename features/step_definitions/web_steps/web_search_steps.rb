When /^User clicks on "search user" under connections tab$/ do
 page.find("#{@app.home.menu.connections}").trigger(:mouseover)
 # @app.home.menu.connections.search_users_link.click
end

# When /^User navigates to search page$/ do
#   retry_on_timeout do
#     @app.home.load
#    @app.home.wait_until_header_visible
#    @app.search.load 
#   end 
# end

When /^User searches for "([^\"]*)" and clicks search$/ do |search_query|
  retry_on_timeout do
  @app.search.load 
  @app.search.wait_for_search_box
  @app.search.should have_search_box
end
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
  retry_on_timeout do    
  @app.search.wait_for_username
  @app.search.should have_username
  end
  @app.search.username.text.should == "#{user.name}"
  @app.search.unlinked_user.click
  @app.search.wait_for_connection_alert
end

When /^User should see the users$/ do |users_table|
  retry_on_timeout do    
  @app.search.wait_for_username
  @app.search.should have_username
end
  users_table.hashes.each do |hash|  
  user = @users.find{|user| user.identifier == hash[:USER]}
  @app.search.username.text.should == "#{user.name}"
  end 
end

When /^User should see the search error$/ do  
  @app.search.wait_for_error_notice
  @app.search.error_notice.text.should == "Sorry!, Unable to find user with entered criteria"
end

Then /^User should see "(.*?)" as an "(.*?)" connection$/ do |identifier, connection_status|
  user = @users.find{|user| user.identifier == identifier}
  retry_on_timeout do    
    @app.search.wait_for_username(10)
    @app.search.should have_username
  end
    @app.search.username.text.should == "#{user.name}"
    @app.search.should have_unlinked_user if(connection_status == "unlinked")
    @app.search.should have_pending_request_user if(connection_status == "request pending")
    @app.search.should have_pending_response_user if(connection_status == "response pending")
end


Then /^User should see "(.*?)" without any connection status$/ do |username|
  user = @users.find{|user| user.identifier == username}
  retry_on_timeout do    
  @app.search.wait_for_username
  @app.search.should have_username
end
  @app.search.username.text.should == "#{user.name}"
      @app.search.should_not have_unlinked_user 
      @app.search.should_not have_pending_request_user 
      @app.search.should_not have_pending_response_user 
end

When /^User searches for the Super Admin$/ do
  retry_on_timeout do
    @app.search.wait_for_search_box
    @app.search.should have_search_box
  end
  @app.search.search_box.set "#{user.name}" 
  @app.search.search_button.click
  @app.search.wait_for_error_notice
end








