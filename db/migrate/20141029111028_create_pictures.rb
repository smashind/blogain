class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :imagename
      t.integer :image_id
      t.string :image_type

      t.timestamps
    end
  end
end
