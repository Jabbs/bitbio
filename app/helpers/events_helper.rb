module EventsHelper
  
  def date_time_info(event)
    event.start_date.strftime('%b %e') + ", " + event.start_date.strftime('%l:%M%P') + " -- " + event.end_date.strftime('%b %e') + ", " + event.end_date.strftime('%l:%M%P')
  end
  
end
