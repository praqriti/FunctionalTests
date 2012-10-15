class MyWall < SitePrism::Page
  
  element :about_page_link, "li.user_name"
  element :logout_link, "li.logout"
  
  section :menu, MenuSection, "ul#menu"
    
  element :user_name, "div.profile_headings h2"
  element :full_name, "table.profile_table tbody tr td.name"
  element :display_name, "table.profile_table tbody tr td.short_name"
  element :profile_picture, "div.profile_headings img"
  
  element :status_message, "div#status_message em"
  element :comment_box, "input#comment_message.autoclearInput"
  element :comment_submit, "form#new_comment.new_comment input.submit"
  element :comment_text, "div#comments fieldset.comment fieldset span.comment_text"
  element :commented_by, "span.commented_by"
  element :commented_at, "span.created_at"
  element :error_message, "form#new_comment.new_comment div.error_msg"
  
end