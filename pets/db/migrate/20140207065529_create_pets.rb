class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.text :description
      t.string :breed
      t.integer :age
      t.string :image_url

      t.timestamps
    end
  end
end
