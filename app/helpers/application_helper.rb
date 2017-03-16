module ApplicationHelper

  def formatted_date(date)
    if date
      date.strftime('%d/%m/%Y a las %I:%M %p')
    end
  end

end
