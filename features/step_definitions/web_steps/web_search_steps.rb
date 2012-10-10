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


When /^User searches for "([^\"]*)" and clicks search$/ do |search_query|
  
end

When /^User should see the users:$/ do |table|
  # table is a Cucumber::Ast::Table
end

When /^User navigates to search page$/ do
  @app.search.load
end

