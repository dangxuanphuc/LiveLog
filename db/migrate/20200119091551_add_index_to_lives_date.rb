class AddIndexToLivesDate < ActiveRecord::Migration[6.0]
  def change
    add_index :lives, :date
  end
end
