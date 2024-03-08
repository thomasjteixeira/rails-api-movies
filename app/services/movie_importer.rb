class MovieImporter
  def self.import_movie_tmdb(id: nil, title: nil)
    tmdb_movie = fetch_tmdb_movie(id:, title:)
    create_movie_from_tmdb_movie(tmdb_movie)
  end

  def self.fetch_tmdb_movie(id: nil, title: nil)
    if id
      Tmdb::Movie.detail(id)
    else
      search_results = Tmdb::Movie.find(title).results
      search_results.present ? Tmdb::Movie.detail(search_results.first.id) : nil
    end
  end

  def self.create_movie_from_tmdb_movie(tmdb_movie)
    return unless tmdb_movie

    movie_attributes = extract_movie_attributes(tmdb_movie)
    Movie.create!(movie_attributes)
  end

  def self.extract_movie_attributes(tmdb_movie)
    Movie.attribute_names.each_with_object({}) do |attr, hash|
      hash[attr] = tmdb_movie.send(attr) if tmdb_movie.respond_to?(attr)
    end
  end
end
