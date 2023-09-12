class AddUserIdToDecks < ActiveRecord::Migration[7.0]
  def change
    add_column :decks, :user_id, :integer
  end
end
