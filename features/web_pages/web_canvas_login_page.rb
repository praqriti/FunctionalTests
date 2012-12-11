class CanvasLogin < SitePrism::Page
  set_url "/login?canvas_login=1"
  
  element :forgot_password, "login_forgot_password.forgot_password_link"
  element :email, "#pseudonym_session_unique_id"
  element :password, "#pseudonym_session_password"
  element :message_box, ".messagebox"
  element :sign_in_button, "#login_form div button.button"
  element :message, ".messagebox"  
  element :title, "#modal-box-inner h1"
end
