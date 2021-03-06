class Login < SitePrism::Page
  set_url "/login"
  set_url_matcher /cas\/login/
  
  element :forgot_password, "login_forgot_password.forgot_password_link"
  element :email, "input#username"
  element :password, "input#password"
  element :message_box, "div.messagebox"
  element :sign_in_button, "input.submit"
  element :message, ".messagebox"  
end
