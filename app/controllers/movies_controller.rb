#frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies = Movie.all
    respond_to do |format|
      format.html
      format.json { render json: @movies.to_json(methods: :average_score) }
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: 'Movie was successfully created.'
    else
      render :new
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
