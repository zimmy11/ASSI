class EventsController < ApplicationController
  def index
    @events=Event.all

  end

  def show
    @event=Event.find(params[:id])
  end

  def new
    
  end

  def create
    
    event=Event.new(event_params)
    if event.save
      flash[:success]="L'evento è stato aggiunto correttamente"
      redirect_to index_event_path
    else 
      flash[:error]="Si è verificato un errore nella creazione dell'evento"
    end
   end

  def edit
    @event=Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:success] = "L'evento è stato aggiornato correttamente."
      redirect_to event_path
    else
      # Errore nell'aggiornamento
      flash[:error] = "Si è verificato un errore nell'aggiornamento dell'evento."
      render :edit
    end
  end

  def destroy
    @event=Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end
  private

def event_params
  params.require(:event).permit(:title, :date, :price, :location, :limit)
end
end
