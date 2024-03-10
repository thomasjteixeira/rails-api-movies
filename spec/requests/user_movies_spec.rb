# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UserMovies', type: :request do
  let!(:user) do
    User.create!(username: 'admin', email: 'admin@rotten', password: 'admin', password_confirmation: 'admin',
                 admin: true)
  end
  let!(:user1) { User.create!(username: 'joao', email: 'joao@rotten', password: 'joao', password_confirmation: 'joao') }
  let!(:user2) do
    User.create!(username: 'maria', email: 'maria@rotten', password: 'maria', password_confirmation: 'maria')
  end
  let!(:file) { fixture_file_upload('movie_scores_to_imports.csv', 'text/csv') }
  let!(:movie1) { Movie.create!(id: 11, title: 'Guerra nas Estrelas') }
  let!(:movie2) { Movie.create!(id: 693_134, title: 'Duna: Parte Dois') }
  let!(:movie3) { Movie.create!(id: 188_927, title: 'Star Trek: Sem Fronteiras') }
  let!(:movie4) { Movie.create!(id: 550, title: 'Clube da Luta') }

  describe 'POST /user_movies/import_movie_scores' do
    subject { post '/user_movies/import_movie_scores', params: { file: } }

    context 'when the user is authenticated' do
      before do
        post sessions_path, params: { email: user.email, password: user.password }
      end

      context 'when the file is processed successfully' do
        it 'imports the movies scores and return a success message' do
          num_movie_score_to_import = File.readlines(file.path).size - 1

          expect { post '/user_movies/import_movie_scores', params: { file: } }
            .to change { UserMovie.count }.by(num_movie_score_to_import)

          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)['message']).to eq('Movies scores imported successfully.')
        end
      end
    end

    context 'when the user is not authenticated' do
      include_examples 'unauthenticated access'
    end
  end
end
