class Comment < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :post

  validates :text, presence: true

  after_save :update_comment_counter

  private

  def update_comment_counter
    post.increment!(:comment_counter)
  end
end