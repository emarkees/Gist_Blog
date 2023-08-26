require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create(name: 'Mary', posts_counter: 0) }

  context '#validation' do
    it 'should accept name and posts_counter and save to the database' do
      expect(subject).to be_valid
    end

    it 'should validate_presence_of(:name)' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should validate_presence_of(:posts_counter)' do
      subject.posts_counter = 0
      expect(subject).to be_valid
    end

    it 'should validate_integer_is_positive(:posts_counter)' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end

    it 'expect posts_counter should be an integer' do
      subject.posts_counter = 2.5
      expect(subject).to_not be_valid
    end
  end

  
end