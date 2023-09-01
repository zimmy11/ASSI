Feature: Fare Log in

 Feature: Gestione dell'accesso utente

  Background: SignUp in User
   Given Sono nella pagina di sign up
   And  inserisco nel form username "zimmy11"
   And  inserisco nel form email "zimmatore.1947442@studenti.uniroma1.it"
   And inserisco nel form ruolo "organizer"
   And  inserisco nel form password "745&&ma1"
   And  inserisco nel form conferma password "745&&ma1"
   When clicco su Sign Up
   Then dovrei essere reindirizzato alla pagina del Profilo
    When clicco sul tasto di Logout
    Then la pagina corrente dovrebbe essere la pagina di log_in

  Scenario: Reindirizzamento alla pagina di Sign up
    When clicco sul pulsante Sign up
    Then dovrei essere reindirizzato alla pagina di Sign up

  Scenario: Reindirizzamento alla pagina di Log in
    When clicco sul pulsante di Log in
    Then la pagina corrente dovrebbe essere la pagina di log_in

  Scenario: Tentativo Log in con dati invalidi
    When riempio il form di log in con email "zimmatore.1947442@studenti.uniroma1.it"
    And inserisco nel form la password "000000"
    And clicco su log in
    Then la pagina corrente dovrebbe essere la pagina di log_in
    Then dovrei vedere il messaggio "invalid username or password"


  Scenario: Reindirizzamento alla pagina del profilo dopo Log in valido
    When inserisco nel form l'email "zimmatore.1947442@studenti.uniroma1.it"
    And inserisco nel form la password "745&&ma1"
    And clicco su log in
    Then dovrei essere reindirizzato alla pagina del Profilo
