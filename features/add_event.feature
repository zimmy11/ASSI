Feature: Aggiungere un evento
 Background: SignUp in User
   Given Sono nella pagina di sign up
   And  inserisco nel form username "zimmy11"
   And  inserisco nel form email "zimmatore.1947442@studenti.uniroma1.it"
   And inserisco nel form ruolo "organizer"
   And  inserisco nel form password "745&&ma1"
   And  inserisco nel form conferma password "745&&ma1"
   When clicco su Sign Up
   Then dovrei essere reindirizzato alla homepage
   When clicco sul pulsante +
   Then dovrei essere reindirizzato alla pagina di creazione dell'evento

  Scenario: pubblica un evento
    When ho riempito il form nuovo evento con titolo "My Event" 
    And  inserisco la data "2023-08-31" 
    And inserisco la location "City Hall" 
    And inserisco il prezzo 15
    And premo su "Pubblica"
    Then l'evento dovrebbe essere pubblicato
    And il limite di partecipanti all'evento non dovrebbe essere null
    And le prevendite rimaste all'evento dovrebbero essere pari al limite di partecipanti
    And il valore medio dell'evento dovrebbe essere pari a 0.0

  Scenario: pubblicazione di un evento con dati invalidi
    When ho riempito il form nuovo evento con titolo "" 
    And  inserisco la data "" 
    And inserisco la location "" 
    And premo su "Pubblica"
    Then la pagina dovrebbe avere tra gli errori "Price can't be blank, Title can't be blank, Date can't be blank, Location can't be blank"
    
  Scenario: pubblicazione di un evento senza titolo
    When ho riempito il form nuovo evento con titolo "" 
    And  inserisco la data "2023-08-31" 
    And inserisco la location "City Hall" 
    And inserisco il prezzo 15
    And premo su "Pubblica"
    Then la pagina dovrebbe avere tra gli errori "Title can't be blank"

      
  Scenario: pubblicazione di un evento senza data
    When ho riempito il form nuovo evento con titolo "My Event" 
    And  inserisco la data "" 
    And inserisco la location "City Hall" 
    And inserisco il prezzo 15
    And premo su "Pubblica"
    Then la pagina dovrebbe avere tra gli errori "Date can't be blank"

    Scenario: pubblicazione di un evento senza prezzo
    When ho riempito il form nuovo evento con titolo "My Event" 
    And  inserisco la data "2023-08-31" 
    And inserisco la location "City Hall" 
    And premo su "Pubblica"
    Then la pagina dovrebbe avere tra gli errori "Price can't be blank"

    Scenario: pubblicazione di un evento senza location
    When ho riempito il form nuovo evento con titolo "My Event" 
    And  inserisco la data "2023-08-31" 
    And inserisco la location ""
    And inserisco il prezzo 15
    And premo su "Pubblica"
    Then la pagina dovrebbe avere tra gli errori "Location can't be blank"
