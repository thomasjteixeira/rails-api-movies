class AddFieldsToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :adult, :boolean
    add_column :movies, :backdrop_path, :string
    add_column :movies, :budget, :integer
    add_column :movies, :homepage, :string
    add_column :movies, :imdb_id, :string
    add_column :movies, :original_language, :string
    add_column :movies, :original_title, :string
    add_column :movies, :overview, :text
    add_column :movies, :popularity, :float
    add_column :movies, :poster_path, :string
    add_column :movies, :release_date, :date
    add_column :movies, :revenue, :integer
    add_column :movies, :runtime, :integer
    add_column :movies, :status, :string
    add_column :movies, :tagline, :string
    add_column :movies, :video, :boolean
    add_column :movies, :vote_average, :float
    add_column :movies, :vote_count, :integer
  end
end
