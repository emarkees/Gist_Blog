require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'Oladayo', posts_counter: 0) }

  subject do
    Post.create(user_id: user.id, title: 'My first post', text: 'Here is my post.', comment_counter: 0, like_counter: 0)
  end

  let(:first_comment) do
    Comment.create(post: subject, user:, text: 'first comment', created_at: 'Fri, 28 Jul 2023 04:51:46')
  end
  let(:second_comment) do
    Comment.create(post: subject, user:, text: 'second comment', created_at: 'Fri, 28 Jul 2023 05:51:46')
  end
  let(:third_comment) do
    Comment.create(post: subject, user:, text: 'third comment', created_at: 'Fri, 28 Jul 2023 06:51:46')
  end
  let(:fourth_comment) do
    Comment.create(post: subject, user:, text: 'fourth comment', created_at: 'Fri, 28 Jul 2023 07:51:46')
  end
  let(:fifth_comment) do
    Comment.create(post: subject, user:, text: 'fifth comment', created_at: 'Fri, 28 Jul 2023 08:51:46')
  end
  let(:sixth_comment) do
    Comment.create(post: subject, user:, text: 'sixth comment', created_at: 'Fri, 28 Jul 2023 09:51:46')
  end

  let(:first_like) { Like.create(post: subject, user:) }
  let(:second_like) { Like.create(post: subject, user:) }

  shared_examples 'a non-negative integer' do |attribute|
    it 'counter should not be a negative number' do
      subject.send("#{attribute}=", -1)
      expect(subject).to_not be_valid
    end

    it 'counter should be greater than or equal to zero' do
      subject.send("#{attribute}=", 0)
      expect(subject).to be_valid

      subject.send("#{attribute}=", 1)
      expect(subject).to be_valid
    end

    it 'counter should be an integer' do
      subject.send("#{attribute}=", 1.5)
      expect(subject).to_not be_valid
    end
  end

  context '#validation' do
    it 'should validate_presence_of(:title)' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'should validate_length_of(:title).is_at_most(250)' do
      subject.title = 'a' * 250
      expect(subject).to be_valid

      subject.title = 'a' * 251
      expect(subject).to_not be_valid
    end

    it 'should validate_integer(:comment_counter)' do
      subject.comment_counter = 1.7
      expect(subject).to_not be_valid
    end

    it 'should validate_integer_greater_than_zero(:comment_counter)' do
      subject.comment_counter = 1
      expect(subject).to be_valid
    end
  end
  context '#callbacks' do
    it 'should increment the user\'s posts_counter after save' do
      expect do
        Post.create(user_id: user.id, title: 'My first post', text: 'Here is my post', comment_counter: 0,
                    like_counter: 0)
        user.reload
      end.to change(user, :posts_counter).by(1)
    end
  end
  context '#recent_comments' do
    it 'should return the most recent comments' do
      first_comment
      second_comment
      third_comment
      fourth_comment
      fifth_comment
      sixth_comment

      recent_comments = subject.recent_comments

      expect(recent_comments.length).to eq(5)
      expect(recent_comments).to eq([sixth_comment, fifth_comment, fourth_comment, third_comment, second_comment])
    end
  end
end
