require 'csv'
class MovieImporterWorker
  include Sidekiq::Worker

  def perform(file_path)
    return unless File.exist?(file_path)

    CSV.foreach(file_path, headers: true) do |row|
      MovieImporter.import_movie_tmdb(id: row['id'].to_s, title: row['title'])
    rescue StandardError => e
      Sidekiq.logger.error "Failed to import movie: #{e.message}"
    end
  rescue StandardError => e
    Sidekiq.logger.error "Failed to process file: #{e.message}"
  end
end
