class EventsController < ApplicationController
  before_action :authenticate_user!
  def index
    if params[:status]=="draft"
      @events=Event.where(status:"draft",organizer_id: current_user.id)
    elsif params[:commit]=="organised"
      @events=Event.where(status: "published", organizer_id: params[:organizer_id])
    elsif params[:commit]=="presale"
      @events=[]
      presales=Presale.where(user_id: params[:user_id])
      presales.each do |presale|
        @events.push(Event.find(presale.event_id)) unless @events.include?(Event.find(presale.event_id))
      end
    else
      @events = Event.where(status: "published")
      if params[:search].present?
        @events = @events.where("location LIKE ?", "%#{params[:search]}%")
      end
    end
    if params[:sort_by] == "price"
      @events = @events.order(price: :asc)
    elsif params[:sort_by] == "avgvalue"
      @events = @events.order(avgvalue: :desc)
    elsif params[:sort_by] == "date"
       @events = @events.order(date: :asc)
    else
      # Ordine predefinito (per esempio, per avgvalue più alto)
      @events = @events.order(avgvalue: :desc)
    end
    @events = @events.where("date > ?", Date.today)
  end

  def show
    @is_event_background=true
    @event=Event.find(params[:id])
    respond_to do |format|
      format.html { render :show}
      format.json { render :show, status: :created, location: @event }
    end
  end

  def new
    @is_event_background=true
    @event=Event.new
  end

  def create
    
    # Voglio che quando clicco su "Salva bozza" la verifica di presenza sia solo su "date" e "title"
    @event = Event.new(event_params.merge(organizer_id: current_user.id))
  
    if params[:commit] == 'Bozza'
      @event.status = 'draft'
      if @event.save
        redirect_to @event, notice: 'Bozza salvata con successo.'
      else
        flash[:error]=@event.errors.full_messages.join(",")
        redirect_to new_event_path
      end
    elsif params[:commit] == 'Pubblica'
      @event.status = 'published'
      if params[:organizer]
        @event.organizer_id = params[:organizer]
      end
      if @event.valid?
        if @event.save
          flash[:success] = 'L\'evento è stato creato con successo!'
          redirect_to events_path
        else
          flash[:error] = @event.errors.full_messages.join(", ")
          redirect_to new_event_path
        end
      else
        flash[:error] = @event.errors.full_messages.join(", ")
        redirect_to new_event_path
      end
    elsif params[:commit] == 'Pubblica Bozza'
      @event.status = 'published'
      if @event.valid?
        if @event.save
          flash[:success] = 'L\'evento è stato creato con successo!'
          redirect_to events_path
        else
          flash[:error] = @event.errors.full_messages.join(", ")
          render json: { error:"Errore nel salvataggio" }, status: :bad_request
          redirect_to edit_event_path(id: params[:id])
        end
      else
        flash[:error] = @event.errors.full_messages.join(", ")
        redirect_to edit_event_path(id: params[:id])
      end
    end

 
  end
  



  def edit
    @is_event_background=true

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
    params.require(:event).permit(:title, :date, :price, :location,:limit,:description)
  end

  
end
 


