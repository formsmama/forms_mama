class RemoveUniqIndexFromSessionToken < ActiveRecord::Migration
  def change
    remove_index :documents, :session_uniq_token
  end
end
