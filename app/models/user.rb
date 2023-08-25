class User < ApplicationRecord
  has_many :posts, foreign_key: :user_id
  has_many :comments
  has_many :likes

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def increment_posts_counter
    update(posts_counter: posts_counter + 1)
  end
end
