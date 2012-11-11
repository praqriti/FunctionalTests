class Messages
  attr_reader :teacher_with_no_quiz, :teacher_with_pending_invitation, :student_with_no_quiz, :student_with_pending_invitation, :invalid_option, :home_page,
  :no_course_attached, :incorrect_credentials, :status_updated, :something_went_wrong, :enter_password
  
  def initialize
 @teacher_with_no_quiz = "Attached to course as Teacher\\nNo Quiz Attached"
 @teacher_with_pending_invitation = "Attached to course as Teacher\\nPlease log in to Web, to respond to Course request"
 @student_with_no_quiz = "Attached to course as Student\\nNo Quiz Attached"
 @student_with_pending_invitation = "Attached to course as Student\\nPlease log in to Web, to respond to Course request" 
 @invalid_option = "Invalid Option \\nWelcome to SEN!"
 @home_page = "Welcome to SEN!"
 @no_course_attached = "No Course Attached"
 @incorrect_credentials = "Incorrect Username/ Password"
 @status_updated = "Status Updated\\n"
 @something_went_wrong = "Something went wrong. Please try again"
 @enter_password = "Enter your password"
 end
 
 def get(message)
   instance_variable_get("@#{message}")
 end
end