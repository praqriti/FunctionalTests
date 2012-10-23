Given /^User navigates to quiz page and creates following quiz$/ do |table|
  @quizzes = table.hashes
  table.hashes.each do |test|
    Quiz.set_page_url @course.id
    @app.quiz.load
    @app.quiz.wait_until_new_quiz_button_visible
    @app.quiz.new_quiz_button.click
    @app.quiz.wait_until_publish_button_visible
    @app.quiz.quiz_name_field.set "#{test["TEST"]}"
    @app.quiz.publish_button.click
    @app.quiz.wait_until_quiz_name_header_visible
 end
end