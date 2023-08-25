class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post

  private

  def increment_post_comment_counter
    post.increment_comment_counter
  end

  def increment_comment_counter
    update(comment_counter: self.comment_counter + 1)
  end

  after_create :increment_post_comment_counter
end
