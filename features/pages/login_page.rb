Then /^I am on the 'Sign In' page$/ do
  @signin_page = SignIn.new
  @signin_page.load
  p @signin_page.current_url
  @signin_page.wait_until_sign_in_button_visible
  @signin_page.should be_displayed
  
  @signin_page.should have_remember_me
end


And /^enter the 'Sign In' details$/ do
  @signin_page.email.set "psingh@thoughtworks.com"
  @signin_page.password.set "password"
  @signin_page.sign_in_button.click
end 
  
Then /^I should be 'logged in'$/ do
  @signin_page = SignIn.new
  @signin_page.should be_displayed
end