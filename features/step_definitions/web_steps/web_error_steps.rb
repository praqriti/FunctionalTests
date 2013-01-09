And /^User navigates to the url "(.*?)"$/ do  |url|
  visit url
end

Then /^User should see "404" error page$/ do
  @app.error_404_page.heading.text.should == "Page Not Found"
end

Then /^User should see "unauthorised" error page$/ do
  @app.unauthorised_error_page.heading.text.should == "Unauthorised"
end
