class CreateDestinations < ActiveRecord::Migration[5.0]
  def change
    create_table :destinations do |t|
      t.float :latitude
      t.float :longitude
      t.string :description
      t.string :title

      t.timestamps
    end
  end
end
