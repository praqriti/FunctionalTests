And /^User publishes the "([^\"]*)" course$/ do |course_name|
  @app.course.load
  @app.course.wait_until_my_courses_visible
  @app.course.courses.select{|course| course.text == course_name}.first.click
  @app.course.wait_until_wizard_box_visible
  @app.course.publish_link.click
  @app.course.publish_button.click
  @app.course.wait_until_publish_success_visible
end