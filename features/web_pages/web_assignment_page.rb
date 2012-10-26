class Assignment < SitePrism::Page
  def self.set_page_url course_id
    self.set_url "/courses/#{course_id}/assignments"
  end

  element :update_button, 'button.button'
  element :group_name, 'input#assignment_group_name'
  element :add_group, 'a.add_group_link'
end
