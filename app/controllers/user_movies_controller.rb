require 'csv'

class UserMoviesController < ApplicationController
  before_action :authenticate_user!

  def create
    @movie = Movie.find(params[:user_movie][:movie_id])
    current_user.movies << @movie
    @user_movie = current_user.user_movies.find_by(movie_id: @movie.id)
    @user_movie.update(score: params[:user_movie][:score])
    redirect_to movies_path
  end

  def update
    @user_movie = current_user.user_movies.find_by(movie_id: params[:user_movie][:movie_id])
    @user_movie.update(score: params[:user_movie][:score])
    redirect_to movies_path
  end

  def import_movie_scores
    CSV.foreach(params[:file].path, headers: true) do |row|
      MovieScoresImporter.import_movie_scores(movie_id: row['movie_id'].to_s, user_id: row['user_id'].to_s,
                                              score: row['score'])
    end
    render json: { message: 'Movies scores imported successfully.' }, status: :ok
  rescue StandardError => e
    render json: { message: "Error importing scores: #{e.message}" }, status: :unprocessable_entity
  end
end
