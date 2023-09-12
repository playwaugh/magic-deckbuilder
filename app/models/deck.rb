class Deck < ApplicationRecord
  has_many :cards, dependent: :destroy
  belongs_to :user
  validates :title, :description, presence: true
end
