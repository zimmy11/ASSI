require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  
    describe "POST /create" do
        before(:each) do
          # Crea un utente autenticato prima di ogni test
          @user = User.create(username: "Prova",email: "test@example.com", password: "password",role:"admin")
          sign_in @user
        end 
        context "with valid parameters" do
          it "redirects to the homepage after creating a new event" do
            @user = User.create(username: "Prova",email: "test@example.com", password: "password",role:"admin")
            sign_in @user
            event_params = { title: "My Event", price: 50, date: Date.today, location: "Event Location",status:"published" }
            post :create, params: { event: event_params }
            puts response.body
            expect(response).to redirect_to(root_url)
            expect(flash[:success]).to eq("L\'evento è stato creato con successo!")
          end
        end  
      end
end
