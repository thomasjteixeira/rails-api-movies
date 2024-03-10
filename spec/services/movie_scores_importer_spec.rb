# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MovieScoresImporter, type: :service do
  let!(:movie) do
    Movie.create!(title: 'Duna: Parte Dois')
  end
  let!(:user) { User.create!(username: 'admin', email: 'admin@example.com', password: 'password') }
  let!(:score) { 9.9 }

  describe '.import_movie_scores' do
    context 'when valid movie_id, user_id and score are is provided' do
      it 'associates the movie with the user and sets the correct score' do
        expect do
          MovieScoresImporter.import_movie_scores(movie_id: movie.id, user_id: user.id, score:)
                             .end to change(UserMovie, :count).by(1)

          user_movie = UserMovie.find_by(movie:, user:)
          expect(user_movie).to be_present
          expect(user_movie.score).to eq(score)
        end
      end
    end

    context 'when movie_id or user_id is not found' do
      it 'raises an ActiveRecord::RecordNotFound error for an invalid movie_id' do
        expect do
          MovieScoresImporter.import_movie_scores(movie_id: -1, user_id: user.id, score:)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'raises an ActiveRecord::RecordNotFound error for an invalid user_id' do
        expect do
          MovieScoresImporter.import_movie_scores(movie_id: movie.id, user_id: -1, score:)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when no score is provided' do
      it 'does not create a UserMovie association without a score' do
        expect do
          MovieScoresImporter.import_movie_scores(movie_id: movie.id, user_id: user.id, score: nil)
        end.not_to change(UserMovie, :count)
      end
    end
  end
end
