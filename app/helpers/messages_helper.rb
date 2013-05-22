module MessagesHelper
  
  def date_or_time(message)
    if message.created_at.to_date == Date.today
      message.created_at.strftime("%l:%M %P")
    else
      message.created_at.strftime("%b %d")
    end
  end
end
