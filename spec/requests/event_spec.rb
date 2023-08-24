require 'rails_helper'

RSpec.describe "Events", type: :request do

  describe "POST /create" do
    before(:each) do
      # Crea un utente autenticato prima di ogni test
      @user = User.create(username: "Prova",email: "test@example.com", password: "password",role:"admin")
      sign_in @user
    end 
    context "with valid parameters" do
      it "redirects to the homepage after creating a new event" do
        event_params = { title: "My Event", price: 50, date:  "2024-09-21", location: "Event Location" }
        post "/events", params: { event: event_params, commit: "Pubblica"}
        expect(response).to redirect_to(events_url)
        expect(flash[:success]).to eq("L\'evento è stato creato con successo!")
        expect(assigns(:event).status).to eq('published')
        expect(assigns(:event).organizer_id).to eq(@user.id)
      end
    end  
    context "with invalid parameters" do

      it "rimane sulla pagina di creazione di un evento se non vengono inseriti degli attributi" do
        event_params = { title: "", location: "" }
        post "/events", params: { event: event_params, commit: "Pubblica"}
        expect(flash[:error]).to include("Price can't be blank")
        expect(flash[:error]).to include("Title can't be blank") 
        expect(flash[:error]).to include("Date can't be blank")
        expect(flash[:error]).to include("Location can't be blank") 
        expect(response).to redirect_to(new_event_path)
      end


      it "rimane sulla pagina di creazione di un evento se non viene inserita la data" do
        event_params = { title: "My Event", price: 50, location: "Event Location" }
        post "/events", params: { event: event_params, commit: "Pubblica"}
        expect(flash[:error]).to eq("Date can't be blank")
        expect(response).to redirect_to(new_event_path)
      end
      it "rimane sulla pagina di creazione di un evento se viene inserita una descrizione maggiore di 200 caratteri" do
        event_params = { title: "My Event", price: 50,date: "2024-09-21", location: "Event Location",description: "Elegante serata di gala con musica dal vivo, prelibatezze culinarie e un'atmosfera affascinante.Celebrazione eccezionale: un mix straordinario di artisti, cibo delizioso e intrattenimento coinvolgente per tutti." }
        post "/events", params: { event: event_params, commit: "Pubblica"}
        expect(flash[:error]).to eq("Descrizione deve essere lunga al massimo 200 caratteri")
        expect(response).to redirect_to(new_event_path)
      end
      it "rimane sulla pagina di creazione di un evento se viene inserita una data antecedente al giorno di pubblicazione" do
        event_params = { title: "My Event", price: 50,date: "2022-09-21", location: "Event Location" }
        post "/events", params: { event: event_params, commit: "Pubblica"}
        expect(flash[:error]).to eq("Data deve essere maggiore della data odierna")
        expect(response).to redirect_to(new_event_path)
      end 
    
    it "rimane sulla pagina di creazione di un evento se non viene inserito il titolo" do

        event_params = { price: 50,date: "2024-09-21", location: "Event Location" }
        post "/events", params: { event: event_params, commit: "Pubblica"}
        expect(flash[:error]).to eq("Title can't be blank")
        expect(response).to redirect_to(new_event_path)
      end
    it "rimane sulla pagina di creazione di un evento se non viene inserita la location" do

        event_params = { title: "My Event", price: 50,date: "2024-09-21" }
        post "/events", params: { event: event_params, commit: "Pubblica"}
        expect(flash[:error]).to eq("Location can't be blank")
        expect(response).to redirect_to(new_event_path)
    end
    it "rimane sulla pagina di creazione di un evento se non viene inserito il prezzo" do
      event_params = { title: "My Event",  date: "2024-09-21", location: "Event Location" }
      post "/events", params: { event: event_params, commit: "Pubblica"}
      expect(flash[:error]).to eq("Price can't be blank")
      expect(response).to redirect_to(new_event_path)
    end
  end
   
  
  end
  describe "GET /users/sign_in" do
    it "goes to sign in page if not authenticated" do
      event_params = { title: "My Event",  date:  "2024-09-21", location: "Event Location" }
      post "/events", params: { event: event_params, commit: "Pubblica"}
      expect(response).to redirect_to(new_user_session_path)
      end
  end
    
     

 end
