Feature: Registrazione con ruolo corretto e permessi corretti abilitati
Background: Registrazione di utenti con ruoli diversi
  Given Sono nella pagina di sign up

  And inserisco nel form username "user1"
  And inserisco nel form email "user1@example.com"
  And inserisco nel form ruolo "user"
  And inserisco nel form password "password1"
  And inserisco nel form conferma password "password1"
  When clicco su Sign Up
  Then dovrei essere reindirizzato alla pagina del Profilo
  When clicco sul tasto di Logout
  Then la pagina corrente dovrebbe essere la pagina di log_in

  When clicco sul pulsante Sign up
  When dovrei essere reindirizzato alla pagina di Sign up
  And inserisco nel form username "organizer1"
  And inserisco nel form email "organizer1@example.com"
  And inserisco nel form ruolo "organizer"
  And inserisco nel form password "password2"
  And inserisco nel form conferma password "password2"
  When clicco su Sign Up
  Then dovrei essere reindirizzato alla pagina del Profilo
  When clicco sul tasto di Logout
  Then la pagina corrente dovrebbe essere la pagina di log_in

  When clicco sul pulsante Sign up
  Then dovrei essere reindirizzato alla pagina di Sign up
  And inserisco nel form username "admin1"
  And inserisco nel form email "admin1@example.com"
  And inserisco nel form ruolo "admin"
  And inserisco nel form password "password3"
  And inserisco nel form conferma password "password3"
  When clicco su Sign Up
  Then dovrei essere reindirizzato alla pagina del Profilo
  When clicco sul tasto di Logout
  Then la pagina corrente dovrebbe essere la pagina di log_in

Scenario: Verifica ruolo "user" dopo l'accesso
  When inserisco nel form l'email "user1@example.com"
  And inserisco nel form la password "password1"
  And clicco su log in
  Then dovrei essere reindirizzato alla pagina del Profilo
  And dovrei vedere il mio ruolo come "user"
  And non dovrebbe esserci più l'elemento con id "crea-evento-button"
  And dovrebbe esserci un elemento con id "acquista-premium-link"


Scenario: Verifica ruolo "organizer" dopo l'accesso
  When inserisco nel form l'email "organizer1@example.com"
  And inserisco nel form la password "password2"
  And clicco su log in
  Then dovrei essere reindirizzato alla pagina del Profilo
  And dovrei vedere il mio ruolo come "organizer"
  And dovrebbe esserci un elemento con id "crea-evento-button"
  And non dovrebbe esserci più l'elemento con id "acquista-premium-link"


Scenario: Verifica ruolo "admin" dopo l'accesso
  When inserisco nel form l'email "admin1@example.com"
  And inserisco nel form la password "password3"
  And clicco su log in
  Then dovrei essere reindirizzato alla pagina del Profilo
  And dovrei vedere il mio ruolo come "admin"