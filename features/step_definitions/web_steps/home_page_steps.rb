Then /^I am on the Home page$/ do
  @home_page = Home.new
  @home_page.load
  @home_page.wait_until_status_box_visible
  @home_page.all_there?
end


Then /^"([^\"]*)" should be successfully logged into canvas$/ do |login_id|
  steps %{
    Then I am on the Home page
  }   
  @home_page.about_page_link.text.should == login_id
end

Then /^I log out of my account$/ do
  @signin_page.logout_link.text.should == "Logout"
  @signin_page.wait_until_message_box_visible
end