class CreateImages < ActiveRecord::Migration[6.1]
  def change
    create_table :images, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.string :title
      t.text :description
      t.text :tags
      t.integer :access_level
      t.integer :views
      t.timestamps
    end
  end
end
