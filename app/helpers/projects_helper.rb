module ProjectsHelper
  
  def to_days_ago_or_from_now(days_til_start)
    if days_til_start == 1
      "#{days_til_start} day from now"
    elsif days_til_start > 0
      "#{days_til_start} days from now"
    elsif days_til_start == 0
      "today"
    elsif days_til_start < 0
      "#{days_til_start.abs} days ago"
    end
  end
end
