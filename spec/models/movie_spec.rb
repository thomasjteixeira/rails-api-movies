require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'associations' do
    it { should have_many(:user_movies) }
    it { should have_many(:users).through(:user_movies) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
  end

  describe 'BD indexes' do
    context 'on movies.created_at column' do
      subject { ActiveRecord::Base.connection.index_exists?(:movies, :created_at) }
    end

    it 'existe to improve query performance' do
      is_expected.to be_truthy
    end
  end

  describe '#average_score' do
    let!(:movie) { Movie.create!(title: 'Duna') }

    context 'when there are scores' do
      let!(:user1) do
        User.create!(username: 'joao', email: 'joao@rotten', password: 'joao', password_confirmation: 'joao')
      end
      let!(:user2) do
        User.create!(username: 'maria', email: 'maria@rotten', password: 'maria', password_confirmation: 'maria')
      end
      let!(:user_movie1) { UserMovie.create!(user: user1, movie:, score: 9) }
      let!(:user_movie2) { UserMovie.create!(user: user2, movie:, score: 10) }

      it 'returns the average score of the movie' do
        expect(movie.average_score).to eq(9.5)
      end
    end

    context 'when there are no scores' do
      it 'returns 0' do
        expect(movie.average_score).to eq(0.0)
      end
    end
  end
end
