class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :author_id
      t.timestamps
    end
    add_attachment :images, :image
  end
end
