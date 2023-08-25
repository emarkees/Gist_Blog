class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :increment_post_like_counter

  private

  def increment_post_like_counter
    post.increment_like_counter
  end

  def increment_like_counter
    update(like_counter: like_counter + 1)
  end
end
