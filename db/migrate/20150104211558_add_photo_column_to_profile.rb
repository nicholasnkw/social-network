class AddPhotoColumnToProfile < ActiveRecord::Migration
  def change
     add_attachment :profiles, :photo
  end
end
