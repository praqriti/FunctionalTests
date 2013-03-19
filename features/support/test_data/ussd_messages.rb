# encoding: utf-8
class Messages
  
def initialize
 @messages = {
    :en => {
      :teacher_with_no_quiz => "Attached to course as Teacher\\nNo Quiz Attached\\n0 Home",
      :teacher_with_pending_invitation => "Attached to course as Teacher\\nPlease log in to Web, to respond to Course request\\n0 Home",
      :student_with_no_quiz => "Attached to course as Student\\nNo Quiz Attached\\n0 Home",
      :student_with_pending_invitation => "Attached to course as Student\\nPlease log in to Web, to respond to Course request\\n0 Home",
      :invalid_option => "Invalid Option",
      :home_page => "Welcome to SEN!\\n\\n1 Notifications\\n2 Update Status\\n3 Connections\\n4 Groups\\n5 Courses",
      :no_course_attached => "No Course Attached\\n0 Home",
      :incorrect_credentials => "Incorrect Username/ Password",
      :status_updated => "Status Updated\\n\\n1 Notifications\\n2 Update Status\\n3 Connections\\n4 Groups\\n5 Courses",
      :something_went_wrong => "Something went wrong. Please try again",
      :enter_password => "Enter your password",
      :no_score => "No score available\\n* Back",
      :single_attempt => "You have no attempts left for this quiz\\n* Back",
      :successful_test_attempt => "You have successfully finished the test\\n* Back",
      :connection_menu => "1 My Connections\\n2 Connection Requests\\n0 Home",
      :group_menu => "No announcements on this group\\n1 Make New Announcement\\n* Back",
      :connection_request_accepted => "You and %s are now connected\\n* Back",
      :connection_request_rejected => "You have rejected %s's connection request\\n* Back",
      :connection_response_options => "1 Accept\n2 Reject\n* Back",
      :no_question_added_to_quiz => "No question added to quiz\\n* Back to list of Quizzes",
      :no_announcement_on_group => "No announcement on group\\n0 Home"
    },
    :sw => {
      :home_page => "Karibu sen!\\n\\n1 Ujulisho\\n2 Kubadilisha hadhi\\n3 Rafiki\\n4 Vikundi\\n5 Kozi" ,
      :status_update => "कृपया अपना संदेश दर्ज करें\\n0 Home" ,
      :connections_menu => ""
    }
  }
 end
 
 def get(message, options=[], locale = "en")
   @messages[locale.to_sym][message.to_sym] % options
 end
end
