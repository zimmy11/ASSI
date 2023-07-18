class EvaluationsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @evaluation=Evaluation.new
  end

  def create
    value=params[:value]
    @evaluation=Evaluation.new(event_id: params[:event_id],user_id: current_user.id,value: value)
    respond_to do |format|
    if @evaluation.save
      event=Event.find(params[:event_id])
      event.update_attribute(:avgvalue,Evaluation.where(event_id: event.id).average(:value))
      puts event.avgvalue
      puts "Evento valutato correttamente"
       format.html { redirect_to events_path}
      format.json { render :show, status: :created, location: @event }
    else
      puts "Errore nella valutazione dell'evento"
      render  event_path(event_id: params[:event_id])
    end
  end
  end

  def edit
  end

  def update
  end

  def destroy
    @evaluation=Evaluation.find(params[:id])
    event=@evaluation.event
    if @evaluation.destroy
      event.update_attribute(:avgvalue,Evaluation.where(event_id: event.id).average(:value))
    else 
      puts "Errore nella cancellazione della valutazione"
    end
  end
end
