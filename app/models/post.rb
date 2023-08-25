class Post < ApplicationRecord
  belongs_to :user

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end

  def increment_comment_counter
    update(comment_counter: comment_counter + 1)
  end

  def increment_like_counter
    update(like_counter: like_counter + 1)
  end
end
