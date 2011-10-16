module ApplicationHelper

  def title
    t = content_for :title
    t.blank? ? 'Where have you been?' : t
  end
  
end
