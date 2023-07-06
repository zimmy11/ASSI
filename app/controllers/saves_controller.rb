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
      flash[:success]="Evento salvato con successo"
      redirect_to events_path # Reindirizza a events#index

    else
      flash[:error]="Errore nel salvataggio"
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
      flash[:success]="Evento eliminato dai salvati  con successo"
      redirect_to events_path

    else
      flash[:error]="Errore nell'eliminazione"
      redirect_back(fallback_location: root_path)
    end
  end
end
