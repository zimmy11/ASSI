class EventsController < ApplicationController
  before_action :authenticate_user!
  def index
    @events=Event.all

  end

  def show
    @event=Event.find(params[:id])
  end

  def new
    
    @event=Event.new
    
    
    
  end

  def create
    limit=params[:limit]
    #voglio che quando clicco su bozza la verifica di presenza sia solo su date e title
    @event = Event.new(event_params.merge(limit: limit,organizer_id: current_user.id))

    
    if @event.save
      flash[:success] = 'L\'evento è stato creato con successo!'
      redirect_to events_path
    else 
      flash[:error]= @event.errors.full_messages.join(', ')
      render :new
    end
    
    
  end



  def edit
    @event=Event.find(params[:id])
    authorize! :edit, @movie, :message => "BEWARE: you are not authorized to edit movies."
  end

  def update
    @event = Event.find(params[:id])
    limit=params[:limit]
    if @event.update(event_params.merge(limit:limit))
      flash[:success] = 'L\'evento è stato aggiornato con successo!'
      redirect_to event_path
    else
      # Errore nell'aggiornamento
      @event.print_errors    
      render :edit
    end
  end

  def destroy
    @event=Event.find(params[:id])
    if @event.destroy
      flash[:success] = 'L\'evento è stato eliminato con successo!'
      redirect_to events_path
    else
      @event.print_errors    
    end
  end
  def event_params
    params.require(:event).permit(:title, :date, :price, :location)
  end
  
end
 


