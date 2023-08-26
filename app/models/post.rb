class Post < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_post_counter
    user.increment!(:posts_counter)
  end

  after_save :update_post_counter
end
