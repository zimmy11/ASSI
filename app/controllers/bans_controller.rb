class BansController < ApplicationController
    before_action :authenticate_user!
  def index
  end

  def show
  end

  def new
    @ban=Ban.new(user_id: params[:user_id],admin_id: current_user.id)
    if @ban.save
      flash[:success]="Utente bannato correttamente"
    else
      flash[:error]="Errore nel ban"
    end
    redirect_to user_path(id: params[:user_id])
  end

  def create
    
  end

  def edit
  end

  def update
  end

  def destroy
    @ban=Ban.find(params[:id])
    if @ban.destroy
      flash[:success]="Utente sbannato con successo"
    else
      flash[:error]="Errore nello sban"
    end
    redirect_to user_path(id: params[:user_id])

  end
end
