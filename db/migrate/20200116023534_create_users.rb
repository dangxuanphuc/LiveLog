class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :furigana
      t.string :nickname
      t.string :email
      t.integer :joined
      t.boolean :admin, default: false
      t.string :password_digest
      t.string :remember_digest

      t.timestamps
    end
  end
end
