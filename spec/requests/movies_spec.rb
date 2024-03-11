# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Movies', type: :request do
  let!(:user) do
    User.create!(username: 'admin', email: 'admin@rotten', password: 'admin', password_confirmation: 'admin',
                 admin: true)
  end
  let!(:file) { fixture_file_upload('movies_to_imports.csv', 'text/csv') }

  describe 'POST /movies/import_movies' do
    subject { post '/movies/import_movies', params: { file: } }

    context 'when the user is authenticated' do
      before do
        post sessions_path, params: { email: user.email, password: user.password }
      end

      context 'when the file is processed successfully' do
        it 'imports the movies and return a success message' do
          num_movies_to_import = File.readlines(file.path).size - 1

          VCR.use_cassette('movies_import') do
            expect { post '/movies/import_movies', params: { file: } }
              .to change { Movie.count }.by(num_movies_to_import)
          end

          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)['message']).to eq('Movies imported successfully.')
        end
      end
    end

    context 'when the user is not authenticated' do
      include_examples 'unauthenticated access'
    end
  end

  describe 'GET /movies' do
    let!(:movie1) { Movie.create!(id: 11, title: 'Guerra nas Estrelas') }
    let!(:movie2) { Movie.create!(id: 693_134, title: 'Duna: Parte Dois') }

    before do
      post sessions_path, params: { email: user.email, password: user.password }
      get '/movies'
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns all movies' do
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST /movies' do
    let(:valid_attributes) { { movie: { title: 'Duna', director: 'Denis Villeneuve' } } }

    context 'when the request is valid' do
      before do
        post sessions_path, params: { email: user.email, password: user.password }
        post '/movies', params: valid_attributes
      end

      it 'creates a movie' do
        expect(JSON.parse(response.body)['movie']['title']).to eq('Duna')
        expect(JSON.parse(response.body)['movie']['director']).to eq('Denis Villeneuve')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before do
        post sessions_path, params: { email: user.email, password: user.password }
        post '/movies', params: { movie: { title: '', director: '' } }
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PATCH /movies/:id' do
    let!(:movie) { Movie.create!(id: 23, title: 'Duna: Parte Dois') }
    let!(:valid_attributes) { { movie: { title: 'Duna Updated', director: 'Denis Villeneuve' } } }

    context 'when the record exists' do
      before do
        post sessions_path, params: { email: user.email, password: user.password }
        patch "/movies/#{movie.id}", params: valid_attributes
      end

      it 'updates the movie' do
        expect(JSON.parse(response.body)['movie']['title']).to eq('Duna Updated')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      before do
        post sessions_path, params: { email: user.email, password: user.password }
        put '/movies/1000', params: valid_attributes
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
