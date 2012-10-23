class Courses < SitePrism::Page
  set_url "/courses"

  elements :courses, "li.active a span.name"
  elements :my_courses, "div#content h2"
  element :publish_link, "a.publish_course_in_wizard_link"
  element :publish_button, "form.edit_course button"
  element :wizard_box, "#wizard_box"
  element :publish_success, 'li.ui-state-success'
end