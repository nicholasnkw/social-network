class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.text :blurb
      t.references :user

      t.timestamps
    end
  end
end
