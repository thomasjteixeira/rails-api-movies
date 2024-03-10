require 'csv'

class MovieScoresImporterWorker
  include Sidekiq::Worker

  def perform(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      MovieScoresImporter.import_movie_scores(movie_id: row['movie_id'].to_s, user_id: row['user_id'].to_s,
                                              score: row['score'])
    end
  end
end
