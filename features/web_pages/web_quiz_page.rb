class Quiz < SitePrism::Page
  def self.set_page_url course_id
    self.set_url "/courses/#{course_id}/quizzes"
  end

  element :new_quiz_button, '.rs-margin-lr a.button'
  element :quiz_name_field, 'input#quiz_title'
  element :publish_button, 'button.publish_quiz_button'
  element :quiz_name_header, 'h2#quiz_title'
end