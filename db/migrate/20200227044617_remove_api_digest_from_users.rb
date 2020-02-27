class RemoveApiDigestFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :api_digest, :string
  end
end
