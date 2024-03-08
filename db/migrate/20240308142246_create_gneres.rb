class CreateGneres < ActiveRecord::Migration[7.1]
  def change
    create_table :gneres do |t|
      t.string :name

      t.timestamps
    end
  end
end
