Given /^User navigates to quiz page of "([^\"]*)" course and creates following quiz$/ do |course_name, table|
  @course = @courses.select { |c| c.name == course_name }.first
  enroll_type = "TeacherEnrollment"
  user_id = CanvasUserInterface.get_user_id
  enrollment_id = CanvasEnrollmentInterface.enroll_user(@course.id, user_id, enroll_type)
  steps %{
          When User is on the Sign In page
          And User "camfed_student" logs into Canvas with her credentials
          Then "camfed_student" should see the Canvas home page
        }
  Quiz.set_page_url @course.id
  @quizzes = table.hashes
  table.hashes.each do |test|
    @app.quiz.load
    @app.quiz.wait_until_new_quiz_button_visible
    @app.quiz.new_quiz_button.click
    @app.quiz.wait_until_publish_button_visible
    @app.quiz.quiz_name_field.set "#{test["TEST"]}"
    @app.quiz.publish_button.click
    @app.quiz.wait_until_quiz_name_header_visible
  end
  CanvasEnrollmentInterface.conclude_enrollment @course.id, enrollment_id
end