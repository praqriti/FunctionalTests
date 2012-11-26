class Quiz < SitePrism::Page
  def self.set_page_url course_id , quiz_id
    self.set_url "/courses/#{course_id}/quizzes/#{quiz_id}"
  end

  element :resume, 'header//a[text()="Resume Quiz"]'
  sections :questions, QuestionsSection, ".question_holder"
end
