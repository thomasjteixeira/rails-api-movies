class CreateProductionCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :production_companies do |t|
      t.string :name
      t.string :logo_path
      t.string :origin_country

      t.timestamps
    end
  end
end
