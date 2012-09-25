Given /^User lands on the search page$/ do
  @app.search = Search.new
  @app.search.wait_until_search_box_visible
  @app.search.all_there?
end

When /^User clicks on "([^\"]*)" under connections tab$/ do
  
end


When /^User searches for "([^\"]*)" and clicks search$/ do |search_query|
  
end

When /^User should see the users:$/ do |table|
  # table is a Cucumber::Ast::Table
end
