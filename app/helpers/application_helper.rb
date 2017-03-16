module ApplicationHelper

  def formatted_date(date)
    date.strftime('%d/%m/%Y a las %I:%M %p')
  end

end
