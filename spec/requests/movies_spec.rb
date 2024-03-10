require 'rails_helper'
require 'pry'

RSpec.describe 'Movies', type: :request do
  let(:user) do
    User.create!(username: 'admin', email: 'admin@rotten', password: 'admin', password_confirmation: 'admin',
                 admin: true)
  end

  before do
    post sessions_path, params: { email: user.email, password: user.password }
  end

  describe 'POST /movies/import_movies' do
    let(:file) { fixture_file_upload('movies_to_imports.csv', 'text/csv') }

    context 'when the file is processed successfully' do
      it 'imports the movies and return a success message' do
        VCR.use_cassette('movies_import') do
          post '/movies/import_movies', params: { file: }
        end
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Movies imported successfully.')
      end
    end
  end
end
