class Quiz < SitePrism::Page
  def self.set_page_url course_id , quiz_id
    self.set_url "/courses/#{course_id}/quizzes/#{quiz_id}"
  end

  element :resume, 'header//a[text()="Resume Quiz"]'

  def verify_option_selected question_number, option_number
    xpath = "//div[contains(@class,'question_holder')][position()='#{question_number}']//*[contains(@class, 'answer')][position()='#{option_number}']//input[@checked]"
    self.has_xpath?(xpath).should == true
  end
end
