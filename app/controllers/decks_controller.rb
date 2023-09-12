class DecksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @decks = Deck.all
  end

  def show
    @deck = Deck.find(params[:id])
  end

  def new
    @deck = Deck.new
  end

  def create
    @deck = Deck.new(deck_params)
    @deck.user = current_user
    if @deck.save
      redirect_to @deck, notice: "Deck was successfully created."
    else
      redirect_to new_deck_path, alert: "Deck was not created successfuly."
    end
  end

  private

  def deck_params
    params.require(:deck).permit(:title, :description)
  end
end
