# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies = Movie.all
    render json: @movies.to_json(methods: :average_score), status: :ok
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      render json: { message: 'Movie was successfully created.', movie: @movie }, status: :created
    else
      render json: { errors: @movie.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      render json: { message: 'Movie was successfully updated.', movie: @movie }, status: :ok
    else
      render json: { errors: @movie.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def import_movies
    MovieImporterWorker.perform_async(params[:file].path)
    render json: { message: 'Movies imported successfully.' }, status: :ok
  rescue StandardError => e
    render json: { message: "Error importing movies: #{e.message}" }, status: :unprocessable_entity
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :director)
  end
end
