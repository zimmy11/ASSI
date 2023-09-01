Feature: 

  Background: SignUp in User
    Given Sono nella pagina di sign up
    And inserisco nel form username "zimmy11"
    And inserisco nel form email "zimmatore.1947442@studenti.uniroma1.it"
    And inserisco nel form ruolo "organizer"
    And inserisco nel form password "745&&ma1"
    And inserisco nel form conferma password "745&&ma1"
    When clicco su Sign Up
    Then dovrei essere reindirizzato alla pagina di Profilo
    When clicco su Logout
    Then dovrei essere reindirizzato alla pagina di Log in

  Scenario: Reindirizzamento alla pagina di Sign up
    When clicco sul pulsante Sign in
    Then dovrei essere reindirizzato alla pagina di Sign up

  Scenario: Reindirizzamento alla pagina di Log in
    When clicco sul pulsante Log in
    Then dovrei essere reindirizzato alla pagina di Log in

  Scenario: Tentativo Log in con dati invalidi
    When ho riempito il form di sign in con email ""
    And inserisco la password ""
    Then dovrei essere reindirizzato alla pagina di Log in

  Scenario: Reindirizzamento alla pagina del profilo dopo Log in valido
    When inserisco nel form email "zimmatore.1947442@studenti.uniroma1.it"
    And inserisco nel form password "745&&ma1"
    Then dovrei essere reindirizzato alla pagina di Profilo




