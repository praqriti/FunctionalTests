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
  @app.search.search_box.set "#{search_query}"
  @app.search.search_button.click
end

When /^User should see the users$/ do |users_table|
     @app.search.users.find("#{hash[:USER]}") 
end

When /^User navigates to search page$/ do
  @app.search.load
end

When /^User should see the search error$/ do  
  @app.search.wait_until_search_results_visible
  @app.search.search_results.text.should == "Sorry!, Unable to find user with entered criteria"
end


