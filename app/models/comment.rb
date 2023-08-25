class Comment < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :post

  private

  def increment_post_comment_counter
    post.increment_comment_counter
  end

  after_create :increment_post_comment_counter
end
