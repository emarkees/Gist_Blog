class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :increment_post_comment_counter

  private

  def increment_post_comment_counter
    post.increment_comment_counter
  end
  
  def increment_comment_counter
    update(comment_counter: comment_counter + 1)
  end

end
