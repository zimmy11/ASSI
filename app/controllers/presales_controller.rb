require 'net/http'

class PresalesController < ApplicationController
  before_action :authenticate_user!
  def index
    @event = Event.all
  end

  def show
  end

  def new
    @presale=Presale.new
   
  end

  def create_order
    event_id = params[:event_id]
    event=Event.find(event_id)
    if event.presales_left <=0
      flash[:error]="Non sono più disponibili prevendite per l'evento"
      redirect_to events_path
    end
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
  session[:access_token]= access_token
  puts session.inspect
  puts JSON.parse(response.body)
  # Usa l'access token per le tue richieste successive
else
  # Gestisci l'errore in caso di fallimento della richiesta
  puts "Errore nella richiesta di accesso: #{response.code} - #{response.body}"
end
uri = URI('https://api-m.sandbox.paypal.com/v2/checkout/orders')
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
puts "Questo è il session token " + session[:access_token]+"\n"
request = Net::HTTP::Post.new(uri.path)
request['Content-Type'] = 'application/json'
request['X-Requested-With'] = 'XMLHttpRequest'
request['Authorization'] = "Bearer #{access_token}"
event_price = Event.find(params[:event_id]).price

payload = {
  intent: 'CAPTURE',
  purchase_units: [
    {
      
      amount: {
        currency_code: 'EUR',
        value: event_price
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
        return_url:  "https://loved-pangolin-hip.ngrok-free.app/events/"+event_id+"/presales/capture_order",
        cancel_url: "https://loved-pangolin-hip.ngrok-free.app/events/"+event_id+"/presales/cancel_order"

      }
    }
  }
}

request.body = payload.to_json
response = http.request(request)
puts response.body

links=JSON.parse(response.body)['links']
approve_url=nil
links.each do |link|
  if link['rel'] == 'payer-action'
    approve_url = link['href']
    break
  end
end
puts approve_url
if JSON.parse(response.body)["status"]=="PAYER_ACTION_REQUIRED"
  puts "Sto reindirizzando a "+ approve_url+"\n"
  session[:approve_url] = approve_url
  redirect_to event_path(id:event_id)
else
  flash[:error]="Errore nel pagamento"
  session.delete(:approve_url)
  redirect_to event_path(id:event_id)
end
end




#capture payment
def capture_order
@event = Event.find( params[:event_id])

token=params[:token]
id=params[:PayerID]
puts id 
puts token
puts  session[:access_token]

puts session.inspect
capture_url = "https://api-m.sandbox.paypal.com/v2/checkout/orders/#{token}/capture"
capture_uri = URI.parse(capture_url)
capture_http = Net::HTTP.new(capture_uri.host, capture_uri.port)
capture_http.use_ssl = true

capture_request = Net::HTTP::Post.new(capture_uri.path)
capture_request['Content-Type'] = 'application/json'
capture_request['Authorization'] = "Bearer #{session[:access_token]}"
capture_response = capture_http.request(capture_request)
puts capture_request["Authorization"]
puts "Questo è #{capture_response.body}"
data = JSON.parse(capture_response.body)
  
status = data["status"]

if status == "COMPLETED"
  @presale=Presale.new(user_id: current_user.id, event_id: params[:event_id])
  session[:approve_url]=nil
  if @event.presales_left == 0
    flash[:error] = "Non esistono più prevendite per questo evento"
    redirect_to event_path(id: params[:event_id])
  else
    if @presale.save
      presale_left=@event.presales_left - 1
      @event.update(presales_left: presale_left)
      flash[:success]="Il pagamento è stato completato con successo!"
      redirect_to events_path      
    else
    flash[:error]="Errore nel pagamento"
    session[:approve_url]=nil
    redirect_to event_path(id: params[:event_id])
    end
  end  
else
  flash[:error]="Errore nel pagamento"
  session[:approve_url]=nil
  redirect_to event_path(id: params[:event_id])
end
  session[:approve_url]=nil

end
def cancel_order
  flash[:error]="Hai rifiutato il pagamento"
  session[:approve_url]=nil
  redirect_to event_path(id: params[:event_id])
end

  def edit
  end

  def update
  end

  def destroy
  end
 
end
