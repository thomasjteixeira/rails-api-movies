# frozen_string_literal: true

# rubocop:disable Style/NumericLiterals

require 'rails_helper'

RSpec.describe MovieImporter, type: :service do
  let(:movie_id) { 693134 }
  let(:movie_title1) { 'Duna: Parte Dois' }
  let(:movie_title2) { 'Kung Fu Panda 4' }

  describe '.import_movie_tmdb' do
    context 'when a valid ID is provided' do
      it 'successfully import a movie from TMDb', :vcr do
        VCR.use_cassette('tmdb_movie_by_id') do
          expect do
            MovieImporter.import_movie_tmdb(id: movie_id, title: movie_title1)
          end.to change(Movie, :count).by(1)

          movie = Movie.order(created_at: :desc).first # TODO: criar um index para created_at
          expect(movie.title).to eq(movie_title1)
        end
      end
    end

    context 'when no ID is provided and a title is provided' do
      it 'successfully imports a movie from TMDb', :vcr do
        VCR.use_cassette('tmdb_movie_by_title') do
          expect { MovieImporter.import_movie_tmdb(title: movie_title2) }.to change(Movie, :count).by(1)

          movie = Movie.order(created_at: :desc).first
          expect(movie.title).to eq(movie_title2)
        end
      end
    end

    context 'when neither ID nor title are provided' do
      it 'raises an error' do
        VCR.use_cassette('tmdb_movie_not_found') do
          expect { MovieImporter.import_movie_tmdb }.to raise_error('Movie not found on TMDb.')
        end
      end

      it 'raises an error from invalid title', :vcr do
        VCR.use_cassette('tmdb_movie_invalid_title') do
          expect do
            MovieImporter.import_movie_tmdb(title: 'invalid Movie title')
          end.to raise_error('Movie not found on TMDb.')
        end
      end
    end
  end
end
