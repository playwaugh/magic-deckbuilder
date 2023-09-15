require 'rails_helper'

RSpec.describe Deck, type: :model do

  it "is valid with a title, description and user" do
    user = User.create(email: "test@gmail.com")
    deck = Deck.new(title: "My Deck", description: "This is a test deck", user: user)
    expect(deck).to be_valid
  end

  it "has a title no longer than 255 characters" do
    user = User.create(email: "test@gmail.com")
    deck = Deck.new(title: "A" * 266, description: "This is a test deck", user: user)
    expect(deck).not_to be_valid
  end

  it "can only be edited by its creator" do
  end

  it "can only be deleted by its creator" do
  end
end
