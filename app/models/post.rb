class Post < ApplicationRecord
  belongs_to :user

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def increment_posts_counter
    update(posts_counter: posts_counter + 1)
  end
end
