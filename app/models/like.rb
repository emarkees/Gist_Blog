class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :increment_post_like_counter

  private

  def increment_post_like_counter
    post.increment_like_counter
  end
end
