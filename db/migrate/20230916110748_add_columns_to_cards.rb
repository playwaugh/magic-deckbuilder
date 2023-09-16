class AddColumnsToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :mana_cost, :string
    add_column :cards, :image, :string
    add_column :cards, :card_type, :string
    add_column :cards, :cmc, :integer
    add_column :cards, :colors, :string
    add_column :cards, :set_name, :string
    add_column :cards, :rarity, :string
  end
end
