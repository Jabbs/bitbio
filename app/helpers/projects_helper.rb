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
  
  def visability_text(option, name=nil)
    if option == 'public'
      "Viewable to anyone with your #{name.nil? ? 'project' : 'service'} url."
    elsif option == 'private'
      "Viewable and searchable only by verified Bitbio members."
    elsif option == 'locked'
      "Unviewable and unsearchable by anyone except you."
    end
  end
end
