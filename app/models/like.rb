class Like < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :post, foreign_key: 'post_id'

  validates :user_id, uniqueness: true

  after_create :increment_post_like_counter

  private

  def increment_post_like_counter
    post.increment!(:like_counter)
  end
end