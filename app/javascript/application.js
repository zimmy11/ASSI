// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails


import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap" // da inserire per aggiungere il js di bootstrap
import $ from "jquery"



function Ripristina(){
        console.log("Sono in ripristina");
        const stars = document.querySelectorAll('.rating input[type="radio"]');
        for(var i=0; i<stars.length;i++){
          if(stars[i].checked){
              stars[i].checked=false;
          }
        }
        }


function checkForm(event){
          const stars = document.querySelectorAll('.rating input[type="radio"]');
          var length=0;
          var value;
            console.log("Sono dentro la funzione CheckForm");
            const popoverElement = document.querySelector('.rating');
            const popover = new bootstrap.Popover(popoverElement, {
              content: 'Seleziona un voto da 1 a 5 stelle.',
              placement: 'right',
              trigger: 'manual',
              animation: true
            });
          for(var i=0;i<stars.length;i++){
            if(stars[i].checked){
              value=stars[i].value;
              console.log(value);
              length++;
              break;
            }
            
          }
          console.log("Lunghezza pari a " + length);
          
          if (length == 0) {
              // Se la lunghezza è 0, attiva il popover Bootstrap
              event.preventDefault();
             
              popover.show();
          
          }
          else{
            popover.hide();
            var url  = "/events/"+event.target.id+"/evaluations/"+value;
            console.log(url);
            const csrfToken = $('meta[name="csrf-token"]').attr('content');
            $.ajaxSetup({
              headers: {
                'X-CSRF-Token': csrfToken
              }
            });
            // se tutto è ok ed ho selezionato almeno un pulsante allora vengo reindirizzato alla homepage
            //dopo aver salvato la valutazione nel db
            event_id = document.querySelector(".show-myCard").id;
            $.ajax({
              url: url,
              method: "POST", // Puoi specificare il metodo HTTP qui (GET, POST, ecc.)
              dataType: "json", // Indica che il tipo di dati della risposta è JSON
              success: function (data) {
                // Qui puoi gestire la risposta ricevuta dal server (data)
                console.log("Risposta del server:", data);
                // Puoi aggiornare la pagina, mostrare un messaggio di successo, ecc.
                window.location.href= data['redirect_url'];

              },
              error: function (error) {
                // Gestione degli errori
                console.log("Status:", error.status );
                console.log("Risposta:",error.responseText);
                console.log("Intestazioni della risposta:", error.getAllResponseHeaders());
                console.log(error["redirect_url"])
                window.location.href= error["redirect_url"];

              }
            });    

          }
          
          
          
        }

      const form = document.getElementById("event-form");

      function SendForm(event){ //manda richiesta ajax per la pubblicazione di una bozza
        event.preventDefault();
        event_id = document.querySelector(".show-myCard").id;
        console.log(event_id)
        const eventData = {}; // Oggetto per i parametri dell'evento
        const title = form.querySelector("#title").value;
        const date = form.querySelector("#date").value;
        const price = form.querySelector("#price").value;
        const limit = form.querySelector("#limit").value;
        const description = form.querySelector("#description").value;
        const location = form.querySelector("#location").value;

        eventData["title"] = title;
        eventData["price"] = price;
        eventData["date"] = date;
        eventData["limit"] = limit;
        eventData["description"] = description;
        eventData["location"] = location;

        console.log(eventData);
        url = "/events"
        const csrfToken = $('meta[name="csrf-token"]').attr('content');
        $.ajaxSetup({
          headers: {
            'X-CSRF-Token': csrfToken
          }
        });
        $.ajax({
          url: url,
          method: "POST", // Puoi specificare il metodo HTTP qui (GET, POST, ecc.)
          dataType: "json", // Indica che il tipo di dati della risposta è JSON
          data: { event: eventData, commit: "Pubblica Bozza",id: event_id},
          success: function (data) {
            // Qui puoi gestire la risposta ricevuta dal server (data)
            console.log(data);
            console.log(data['redirect_url']);
            window.location.href= data['redirect_url'];
 
                   },
          error: function (error) {
            // Gestione degli errori
            console.log("Status:", error.status );
            console.log("Risposta:",error.responseText);
            console.log("Intestazioni della risposta:", error.getAllResponseHeaders());
            var rispostaJSON = JSON.parse(error.responseText);

             window.location.href= rispostaJSON.redirect_url;


          }
        });    
      }

      
      const pubblica = $(".publish_button");
      console.log(pubblica);

      if (pubblica[0] != null){
        console.log(pubblica[0]);
        pubblica[0].addEventListener("click", SendForm);   
      }
      if(document.getElementById('saves_modal')!=null){
      const modale = new bootstrap.Modal(document.getElementById('saves_modal'));
      console.log(modale);
      if (modale!=null){
          modale.show();
          console.log("Sono nella funzione per aprire la modale");
        
      }
    }
      const valuta = document.getElementsByClassName("valuta");
      console.log("Questo è "+valuta)  
      if(valuta!=null){
      $(document).on("click",".valuta",Ripristina);
      $(document).on("click",".modal-footer .btn-primary",checkForm);}


                
        




 

