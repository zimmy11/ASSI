require 'net/http'
class UsersController < ApplicationController
  before_action :authenticate_user!
 
  def index
    @event = Event.find(params[:id])
    @users = User.joins(:presales).where(presales: { event_id: @event.id }).uniq
    @presales= Presale.where(event_id: @event.id)
  end

  def geolocation
    url = URI.parse('https://ip-geo-location.p.rapidapi.com/ip/check')
    headers = {
      'X-RapidAPI-Key' => '9917380005mshdb6755bf2e2e54ap158693jsndca67ed43af4',
      'X-RapidAPI-Host' => 'ip-geo-location.p.rapidapi.com'
   }
parameters = {
  'format' => 'json',
	'filter' => 'city'
}
# Esegui la richiesta POST per ottenere l'access token
http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
request = Net::HTTP::Post.new(url.path+"?"+ URI.encode_www_form(parameters), headers)
response = http.request(request)
puts response.body

end

  def show
    @is_event_background=true
    @user = User.find(params[:id])
  end
  

  def new
  end

  def create
  end

  def edit
    if params[:commit]=="Revoca"
      @user=User.find(params[:id])
      if @user.update(role: "user" )
        flash[:success]="L\'organizzatore ora è un utente"
      else
        flash[:error]="Non è possibile effettuare questa operazione."
      end
      redirect_to user_path(id: params[:id])
    end

      
  end

  def update
  end
  def create_order
    url = URI.parse('https://api-m.sandbox.paypal.com/v1/oauth2/token')
    headers = {
  'Content-Type' => 'application/x-www-form-urlencoded',
  'Authorization' => 'Basic ' + Base64.strict_encode64("#{ENV['PAYPAL_CLIENT_ID']}:#{ENV['PAYPAL_SECRET_ID']}")
   }
body = {
  grant_type: 'client_credentials'
}
parameters = {
  'response_type' => 'token id_token',
}
# Esegui la richiesta POST per ottenere l'access token
http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
request = Net::HTTP::Post.new(url.path+"?"+ URI.encode_www_form(parameters), headers)
request.set_form_data(body)
response = http.request(request)

# Controlla se la richiesta ha avuto successo e ottieni l'access token
if response.code == '200'
  
  access_token = JSON.parse(response.body)['access_token']
  session[:access_token]=access_token
  puts JSON.parse(response.body)
  # Usa l'access token per le tue richieste successive
else
  # Gestisci l'errore in caso di fallimento della richiesta
  puts "Errore nella richiesta di accesso: #{response.code} - #{response.body}"
end
uri = URI('https://api-m.sandbox.paypal.com/v2/checkout/orders')
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

request = Net::HTTP::Post.new(uri.path)
request['Content-Type'] = 'application/json'

request['Authorization'] = "Bearer #{access_token}"
price = 10

payload = {
  intent: 'CAPTURE',
  purchase_units: [
    {
      
      amount: {
        currency_code: 'EUR',
        value: price
      }
    }
  ],
  payment_source: {
    paypal: {
      experience_context: {
        payment_method_preference: 'IMMEDIATE_PAYMENT_REQUIRED',
        payment_method_selected: 'PAYPAL',
        landing_page: 'LOGIN',
        user_action: 'PAY_NOW',
        return_url:  "https://loved-pangolin-hip.ngrok-free.app/users/"+(current_user.id).to_s+"/capture_order",
        cancel_url: "https://loved-pangolin-hip.ngrok-free.app/users/"+(current_user.id).to_s+"/cancel_order"

      }
    }
  }
}

request.body = payload.to_json
response = http.request(request)
puts response.body
links=JSON.parse(response.body)['links']
approve_premium_url=nil
links.each do |link|
  if link['rel'] == 'payer-action'
    approve_premium_url = link['href']
    break
  end
end
puts approve_premium_url
if JSON.parse(response.body)["status"]=="PAYER_ACTION_REQUIRED"
  session[:approve_premium_url] = approve_premium_url
  redirect_to user_path(id: current_user.id)
else
  flash[:error]="Errore nel pagamento"
  session[:approve__premium_url] = nil
  redirect_to  user_path(id: current_user.id)
end
end

def capture_order
    token=params[:token]
    id=params[:PayerID]
    puts id 
    puts token
    capture_url = "https://api-m.sandbox.paypal.com/v2/checkout/orders/#{token}/capture"
    capture_uri = URI.parse(capture_url)
    capture_http = Net::HTTP.new(capture_uri.host, capture_uri.port)
    capture_http.use_ssl = true

    capture_request = Net::HTTP::Post.new(capture_uri.path)
    capture_request['Content-Type'] = 'application/json'
    capture_request['Authorization'] = "Bearer #{session[:access_token]}"
    capture_response = capture_http.request(capture_request)
    puts "Questo è #{capture_response.body}"
    data = JSON.parse(capture_response.body)
    status = data["status"]

if status == "COMPLETED"
  @user=User.find(current_user.id)
  @user.update(role: "organizer")
  if @user.valid?
  flash[:success]="Il pagamento è stato completato con successo!"
  session[:approve_premium_url] = nil
  redirect_to user_path(id: current_user.id)
  
  else
  flash[:error]="Errore nel pagamento"
  session[:approve_premium_url] = nil
  redirect_to user_path(id: current_user.id)
  end
else
  flash[:error]="Errore nel pagamento"
  session[:approve_premium_url] = nil
  redirect_to user_path(id: current_user.id)
end
session[:approve_premium_url] = nil
   
end

def cancel_order
  flash[:error]="Hai rifiutato il pagamento"
  session[:approve_premium_url] = nil
  redirect_to user_path(id: current_user.id)
end  

  def destroy
  end

  def save_coordinates
     @user=User.find(current_user.id)
    if @user.update(latitude:params[:latitude]) &&  @user.update(longitude: params[:longitude])
     respond_to do |format|
      format.json { render json: { message: "Dati salvati correttamente", redirect_url: events_path}, status: :created}
      end
    else
      respond_to do |format|
        format.json { render json: { message: "Dati errati"}, status: :unprocessable_entity}
    end
  end
  end
end
