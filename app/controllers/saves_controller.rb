class SavesController < ApplicationController
  before_action :authenticate_user!
  def index
    @saves=Save.where(user_id: current_user.id)
  end

  def show
  end

  def new
  end

  def create
    @save=Save.new(user_id: params[:user_id], event_id: params[:event_id])
    if @save.save
      redirect_to events_path # Reindirizza a events#index

    else
      redirect_back(fallback_location: root_path)
    end


  end

  def edit
  end

  def update
  end

  def destroy
    @save=Save.where(user_id: params[:user_id], event_id: params[:event_id]).first
    if @save.destroy
      redirect_to events_path

    else
      redirect_back(fallback_location: root_path)
    end
  end
end
