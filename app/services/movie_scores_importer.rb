class MovieScoresImporter
  class << self
    def import_movie_scores(movie_id: nil, user_id: nil, score: nil)
      movie = find_movie(movie_id)
      user = find_user(user_id)

      return unless score.present?

      associate_movies_and_import_movie_scores(movie, user, score)
    end

    private

    def find_movie(movie_id)
      Movie.find_by(id: movie_id) || raise(ActiveRecord::RecordNotFound, "Movie with ID #{movie_id} not found")
    end

    def find_user(user_id)
      User.find_by(id: user_id) || raise(ActiveRecord::RecordNotFound, "User with ID #{user_id} not found")
    end

    def associate_movies_and_import_movie_scores(movie, user, score)
      return unless movie.present? && user.present? && score.present?

      user_movie = UserMovie.find_or_initialize_by(movie:, user:)
      user_movie.score = score
      user_movie.save!
    end
  end
end
