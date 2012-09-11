class SignIn < SitePrism::Page
  set_url "/login"
  set_url_matcher /login/
  
  element :forgot_password, "login_forgot_password.forgot_password_link"
  element :email, "input#username"
  element :password, "input#password"
  # element :remember_me, "input#pseudonym_session_remember_me"
  element :message_box, "div.messagebox"
  element :sign_in_button, "input.button"
  
  element :about_page_link, "li.user_name"
  element :logout_link, "li.logout"
  
end
