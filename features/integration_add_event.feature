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

   Scenario: Reindirizzamento dalla homepage
   When clicco sul pulsante +
   Then dovrei essere reindirizzato alla pagina di creazione dell'evento

   Scenario: Reindirizzamento dalla pagina Profilo
   When clicco sull' icona utente
   Then dovrei essere reindirizzato alla pagina di Profilo
   When clicco sul pulsante +
   Then dovrei essere reindirizzato alla pagina di creazione dell'evento

   Scenario: Reindirizzamento dalla pagina Eventi Salvati
      When clicco sull' icona Salva
      Then dovrei essere reindirizzato alla pagina degli Eventi Salvati
      When clicco sul pulsante +
      Then dovrei essere reindirizzato alla pagina di creazione dell'evento
    
    Scenario: Reindirizzamento alla homePage dopo la pubblicazione di un evento
    When clicco sul pulsante +
    Then dovrei essere reindirizzato alla pagina di creazione dell'evento
    When ho riempito il form nuovo evento con titolo "My Event" 
    And  inserisco la data "2024-08-31" 
    And inserisco la location "City Hall" 
    And inserisco il prezzo 15
    And premo su "Pubblica"
    Then dovrei essere reindirizzato alla homepage

  Scenario: pubblicazione di un evento con dati invalidi
    When clicco sul pulsante +
    Then dovrei essere reindirizzato alla pagina di creazione dell'evento
    When ho riempito il form nuovo evento con titolo "" 
    And  inserisco la data "" 
    And inserisco la location "" 
    And premo su "Pubblica"
    Then dovrei essere reindirizzato alla pagina di creazione dell'evento

    Scenario: Ricaricamento pagina corrente
     When clicco sul pulsante +
     Then dovrei essere reindirizzato alla pagina di creazione dell'evento
     When clicco sul pulsante +
     Then dovrei essere reindirizzato alla pagina di creazione dell'evento

     Scenario: Reindirizzamento alla homePage dalla Pagina di creazione di un evento
       When clicco sul pulsante +
       Then dovrei essere reindirizzato alla pagina di creazione dell'evento
       When clicco sul pulsante Home
       Then dovrei essere reindirizzato alla homepage

     Scenario: Reindirizzamento al Profilo dalla Pagina di creazione di un evento
        When clicco sul pulsante +
        Then dovrei essere reindirizzato alla pagina di creazione dell'evento
        When clicco sull' icona utente
        Then dovrei essere reindirizzato alla pagina di Profilo
    
    Scenario: Reindirizzamento alla pagina dei Salvati dalla Pagina di creazione di un evento
        When clicco sul pulsante +
        Then dovrei essere reindirizzato alla pagina di creazione dell'evento
        When clicco sull' icona Salva
        Then dovrei essere reindirizzato alla pagina degli Eventi Salvati








