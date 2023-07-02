class EvaluationsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @evaluation=Evaluation.new
  end

  def create
    value=params[:evaluation][:value]
    @evaluation=Evaluation.new(event_id: params[:event_id],user_id: current_user.id,value: value)
    if @evaluation.save
      flash[:success]="Evento valutato correttamente"
      redirect_to events_path
    else
      flash[:success]="Errore nella valutazione dell'evento"
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
