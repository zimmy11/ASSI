class EventsController < ApplicationController
  before_action :authenticate_user!
  def index
    if params[:status]!=nil
      @events=Event.where(status:"draft")
    else
      @events = Event.where(status: "published")
    end

  end

  def show
    @event=Event.find(params[:id])
    respond_to do |format|
      format.html { render :show}
      format.json { render :show, status: :created, location: @event }
    end
  end

  def new
    
    @event=Event.new
  end

  def create
    
    # Voglio che quando clicco su "Salva bozza" la verifica di presenza sia solo su "date" e "title"
    @event = Event.new(event_params.merge(organizer_id: current_user.id))
  
    if params[:commit] == 'Salva bozza'
      @event.status = 'draft'
      if @event.save
        redirect_to @event, notice: 'Bozza salvata con successo.'
      else
        flash[:error]=@event.errors.full_messages.join(",")
        render :new
      end
    elsif params[:commit] == 'Pubblica'
      @event.status = 'published'
      if @event.valid?
        if @event.save
          flash[:success] = 'L\'evento è stato creato con successo!'
          redirect_to events_path
        else
          flash[:error] = @event.errors.full_messages.join(', ')
          render :new
        end
      else
        render :new
      end
    end
  end
  



  def edit
    @event=Event.find(params[:id])
    authorize! :edit, @event, :message => "BEWARE: you are not authorized to edit movies."
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:success] = 'L\'evento è stato aggiornato con successo!'
      redirect_to event_path
    else
      # Errore nell'aggiornamento
      flash[:error]=@event.errors.full_messages.join(', ')
      redirect_to edit_event_path(@event)
    end
  end

  def destroy
    @event=Event.find(params[:id])
    status=@event.status
    if @event.destroy
      if status == "published"
      flash[:success] = 'L\'evento è stato eliminato con successo!'
      redirect_to events_path
      else
        flash[:success] = 'La bozza è stata eliminata con successo!'
        redirect_to events_path(status: "draft")
      end
    else
      flash[:error]=@event.errors.full_messages.join(', ')  
    end
  end
  def event_params
    params.require(:event).permit(:title, :date, :price, :location,:limit)
  end

  
end
 


