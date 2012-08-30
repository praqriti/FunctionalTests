class SignIn < SitePrism::Page
  set_url "login"
  set_url_matcher /login/
  
  element :forgot_password, "login_forgot_password.forgot_password_link"
  element :email, "input#pseudonym_session_unique_id"
  element :password, "input#pseudonym_session_password"
  element :remember_me, "input#pseudonym_session_remember_me"
  element :sign_in_button, "button.button"
  
end
