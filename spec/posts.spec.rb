require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'David', posts_counter: 0) }

  subject do
    Post.create(user_id: user.id, title: 'My first post', text: 'Here is my post.', comment_counter: 0, like_counter: 0)
  end

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
      expect(subject).to be_valid
    end

    it 'should validate_integer_greater_than_zero(:comment_counter)' do
      subject.comment_counter = 1
      expect(subject).to be_valid
    end
  end
end
