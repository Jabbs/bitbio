module LikesHelper
  def is_liked_by_current_user?(item)
    if current_user && item.likes.where(user_id: current_user.id).any?
      true
    else
      false
    end
  end
end
