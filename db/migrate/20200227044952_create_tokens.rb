class CreateTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :tokens do |t|
      t.string :digest, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
