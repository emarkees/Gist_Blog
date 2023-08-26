require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'John', posts_counter: 0) }
  let(:post) { Post.create(user: user, title: 'Hello', text: 'Test post', comment_counter: 0, like_counter: 0) }

  subject { Like.create(user: user, post: post) }

  context '#validation' do
    it 'should validate_uniqueness(:user_id)' do
      second_user = User.create(name: 'David', posts_counter: 0)
      second_like = Like.create(user: second_user, post: post)
      expect(second_like.user).not_to eql(subject.user)
    end
  end

  context 'check associations between user and post' do
    it 'should belong to an user' do
      expect(subject.user).to eq(user)
    end

    it 'should belong to a post' do
      expect(subject.post).to eq(post)
    end
  end

  context 'check if the update_like_counters is working' do
    it 'should increase the likes counter on the post' do
      subject
      expect { post.reload }.to change { post.like_counter }.by(0)
    end
  end 
end
