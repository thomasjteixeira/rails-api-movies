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
end
