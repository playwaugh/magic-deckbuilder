require 'rails_helper'

RSpec.describe Deck, type: :model do
  it "is valid with a title, description and user" do
    user = User.create(email: "test@gmail.com")
    deck = Deck.new(title: "My Deck", description: "This is a test deck", user: user)
    expect(deck).to be_valid
  end
end
