class CreatePlayings < ActiveRecord::Migration[6.0]
  def change
    create_table :playings do |t|
      t.string :inst  # instrument
      t.references :user, null: false, foreign_key: true
      t.references :song, null: false, foreign_key: true

      t.timestamps
    end
    add_index :playings, [:user_id, :song_id], unique: true
  end
end
