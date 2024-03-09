class AddIndexToMoviesCreatedAt < ActiveRecord::Migration[7.1]
  def change
    add_index :movies, :created_at
  end
end
