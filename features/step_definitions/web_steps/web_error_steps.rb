And /^User navigates to the url "(.*?)"$/ do  |url|
  visit url
end

Then /^User should see "404" error page$/ do
  retry_on_timeout do
  @app.error_404_page.wait_for_heading
  @app.error_404_page.should have_heading
  @app.error_404_page.heading.text.should == "Page Not Found"
end
end

Then /^User should see "unauthorised" error page$/ do
  retry_on_timeout do
  @app.unauthorised_error_page.wait_for_heading
  @app.unauthorised_error_page.should have_heading
  @app.unauthorised_error_page.heading.text.should == "Unauthorised"
end
end
