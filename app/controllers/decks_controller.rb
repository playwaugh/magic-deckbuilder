class DecksController < ApplicationController
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_deck, only: [:show, :edit, :update, :destroy]

  def index
    @decks = Deck.all
  end

  def show
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
      redirect_to new_deck_path, alert: "Deck was not created successfully."
    end
  end

  def edit
    authorize @deck
  end

  def update
    authorize @deck
    if @deck.update(deck_params)
      redirect_to @deck, notice: "Deck was edited successfully."
    else
      render :edit
    end
  end

  def destroy
    authorize @deck
    @deck.destroy
    redirect_to decks_path, notice: "Deck was deleted successfully."
  end

  private

  def set_deck
    @deck = Deck.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(:title, :description)
  end

  def user_not_authorized
    redirect_back(fallback_location: root_path)
    flash[:alert] = "You are not authorized to perform this action."
  end
end
