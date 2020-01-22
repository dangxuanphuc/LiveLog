class AddIndexToUsersFurigana < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :furigana
  end
end
