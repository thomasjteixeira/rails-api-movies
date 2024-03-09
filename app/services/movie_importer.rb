class MovieImporter
  class << self
    def import_movie_tmdb(id: nil, title: nil)
      tmdb_movie = fetch_tmdb_movie(id:, title:)
      create_movie_from_tmdb_movie(tmdb_movie)
    end

    private

    def fetch_tmdb_movie(id: nil, title: nil)
      return Tmdb::Movie.detail(id) if id

      search_results = Tmdb::Search.movie(title).results
      return Tmdb::Movie.detail(search_results.first.id) if search_results.present?

      raise 'Movie not found on TMDb.'
    end

    def create_movie_from_tmdb_movie(tmdb_movie)
      return unless tmdb_movie

      movie_attributes = extract_movie_attributes(tmdb_movie)
      Movie.create!(movie_attributes)
    end

    def extract_movie_attributes(tmdb_movie)
      Movie.attribute_names.each_with_object({}) do |attr, hash|
        hash[attr] = tmdb_movie.send(attr) if tmdb_movie.respond_to?(attr)
      end
    end
  end
end
