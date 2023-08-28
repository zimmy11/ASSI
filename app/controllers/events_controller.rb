require 'net/http'

class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    session[:approve_premium_url]=nil 
    session[:approve_url]=nil 
    if params[:status]=="draft"
      @events=Event.where(status:"draft",organizer_id: current_user.id)
      return
    elsif params[:commit]=="organized"
      @events=Event.where(status: "published", organizer_id: params[:organizer_id])
      return
    elsif params[:commit]=="presale"
      
      @events = Event.joins(:presales).where(presales: { user_id: params[:user_id] }).distinct
      return

    else
      @events = Event.where(status: "published")
      if params[:search].present?
        @events = @events.where("location LIKE ?", "%#{params[:search]}%")
      end
    end
    if params[:minPrice].present?
      @events = @events.where('price >= ?', params[:minPrice])
    end
    if params[:maxPrice].present?
      @events = @events.where('price <= ?', params[:maxPrice])
    end
    if params[:minDate].present?
      @events = @events.where('date >= ?', params[:minDate])
    end
    if params[:maxDate].present?
      @events = @events.where('date <= ?', params[:maxDate])
    end
    if params[:sort_by] == "price"
      @events = @events.order(price: :asc)
    elsif params[:sort_by] == "avgvalue"
      @events = @events.order(avgvalue: :desc)
    elsif params[:sort_by] == "date"
       @events = @events.order(date: :asc)
    elsif params[:sort_by] == "distance"
      #uso l'Api di google maps
      if current_user.latitude==nil || current_user.longitude==nil
        flash[:error]="Attiva geolocalizzazione"
        redirect_to event_path
      end
      current_latitude = current_user.latitude
      current_longitude = current_user.longitude
      @events.each do |event|
        city_name = event.location  # Nome della città di cui vuoi ottenere le coordinate
        api_key = 'AIzaSyDhE8iSfvpzBIi_oOpbnbWNNolFN5W3EtI'  # Sostituisci con la tua chiave API
        url = "https://maps.googleapis.com/maps/api/geocode/json"
        params = {
          address: city_name,
          key: api_key
        }
        
        response = HTTParty.get(url, query: params)
        data = JSON.parse(response.body)
        
        if data['status'] == 'OK'
          location = data['results'][0]['geometry']['location']
          latitude = location['lat']
          longitude = location['lng']
          puts "Coordinate di #{city_name}: Latitudine #{latitude}, Longitudine #{longitude}"
          distance =  (6371*(Math::PI)*Math.sqrt((current_latitude-latitude)*(current_latitude-latitude) + Math.cos(current_latitude/57.29578)*Math.cos(latitude/57.29578)*(current_longitude-longitude)*(current_longitude-longitude))/180); #funzione di heaviside per calcolare la distanza
          puts "la distanza è #{distance}"
          event.update(distance: distance)
        else
          flash[:error]= "Errore nella richiesta di geocoding"
        end
        
      end
      @events = @events.order(distance: :asc)
    else
      # Ordine predefinito (per esempio, per avgvalue più alto)
      @events = @events.order(avgvalue: :desc)
    end
    @events = @events.where("date > ?", Date.today)
  end

  def show
    @is_event_background=true  #aggiungo sfondo background
    @event=Event.find(params[:id])
    respond_to do |format|
      format.html { render :show}
      format.json { render :show, status: :created, location: @event }
    end
  end

  def new
    @is_event_background=true  #aggiungo sfondo background
    @event=Event.new
  end

  def create
    
    # Voglio che quando clicco su "Salva bozza" la verifica di presenza sia solo su "date" e "title"
    @event = Event.new(event_params.merge(organizer_id: current_user.id))
    flash[:title]=params[:event][:title]
    flash[:date]=params[:event][:date]
    flash[:price]=params[:event][:price]
    flash[:location]=params[:event][:location]
    flash[:description]=params[:event][:description]
    flash[:limit]=params[:event][:limit]

    if params[:commit] == 'Bozza' #sto salvando come bozza
      @event.status = 'draft'
      if @event.save
        redirect_to @event, notice: 'Bozza salvata con successo.'
      else
        flash[:error]=@event.errors.full_messages.join(",")
        redirect_to new_event_path
      end
    elsif params[:commit] == 'Pubblica'#sto pubblicando di un evento
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
    elsif params[:commit] == 'Pubblica Bozza'# sto pubblicando una bozza
      @event.status = 'published'
      if @event.valid?
        if @event.save
          flash[:success] = 'L\'evento è stato creato con successo!'
          respond_to do |format|
          format.json { render json: { message: "Evento creato correttamente", redirect_url: event_path(id: @event.id)}, status: :created}
          end
        else
          flash[:error] = @event.errors.full_messages.join(", ")
          respond_to do |format|
          format.json do
            render json: { error: "Errore nella creazione", redirect_url: edit_event_path(id: @event.id) }, status: :unprocessable_entity

          end
          end
        end
      
      else
        flash[:error] = @event.errors.full_messages.join(", ")
        respond_to do |format|
          format.json do
            render json: { error: "Errore nella creazione", redirect_url: edit_event_path(id: params[:id]) }, status: :unprocessable_entity

          end
        end
        
      end
      
    end

 
  end
  

  def edit
    @is_event_background=true   #aggiungo sfondo background

    @event=Event.find(params[:id])
    authorize! :edit, @event, :message => "BEWARE: you are not authorized to edit movies."
  end

  def update
    @event = Event.find(params[:id])
    flash[:title]=params[:event][:title]
    flash[:date]=params[:event][:date]
    flash[:price]=params[:event][:price]
    flash[:location]=params[:event][:location]
    flash[:description]=params[:event][:description]
    flash[:limit]=params[:event][:limit]
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
 


