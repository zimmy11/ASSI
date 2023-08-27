class EvaluationsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @evaluation=Evaluation.new
  end

  def create
    value=params[:star_radio]
    puts value
    @evaluation=Evaluation.new(event_id: params[:event_id],user_id: current_user.id,value: value)
       
    if @evaluation.save
      event=Event.find(params[:event_id])
      event.update_attribute(:avgvalue,Evaluation.where(event_id: event.id).average(:value))
      flash[:success]="L\'evento è stato valutato correttamente"
      respond_to do |format|
        format.json { render json: { message: "Evento valutato correttamente"},redirect_url: events_path, status: :created }
      end
    else
      flash[:error] = @evaluation.errors.full_messages.join(', ')
      respond_to do |format|
        format.json {render json: { error: "Errore nella valutazione dell'evento" },redirect_url: event_path(id: params[:event_id],commit: "presale"), status: :unprocessable_entity}
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
