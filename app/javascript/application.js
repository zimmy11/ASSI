// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails


import "@hotwired/turbo-rails"
import "controllers"
import * as bootstrap from "bootstrap"
import $ from "jquery"

document.addEventListener('DOMContentLoaded', function(){
   
  const sendButton = document.querySelector('.modal-footer .btn-primary');
  const valuta=document.querySelector(".valuta");
  // stampa il numero di stelle date
  function Valuta(){
            const stars = document.querySelectorAll('.rating input[type="radio"]');
            var intValue=0;
            var length=0;
              console.log("Sono dentro la funzione "+stars);
      
            for(var i=0;i<stars.length;i++){
              if(stars[i].checked){
                var id =stars[i].id;
                length= id.length;
                console.log("Questo è l'id "+ id);
              }
              
            }
            console.log("Lunghezza pari a " + length);
            
            if (length == 0) {
                // Se la lunghezza è 0, attiva il popover Bootstrap
                const popoverElement = document.querySelector('.rating');
                const popover = new bootstrap.Popover(popoverElement, {
                  content: 'Seleziona un voto da 1 a 5 stelle.',
                  placement: 'right',
                  trigger: 'manual',
                  animation: true
                });
                popover.show();
            
                return;
            }
            else{  

            var value = id[length-1];
            intValue = parseInt(value);
            console.log(intValue);
            const event= document.querySelector(".card-front");
            var event_id=event.id;
            console.log(event_id);
             // Chiudi la modale
            const modal = document.querySelector('#staticBackdrop');
            const modalBackdrop = document.querySelector('.modal-backdrop');
            modal.style.display = 'none';
            modalBackdrop.style.display = 'none';
            //richiesta ajax che sostituisce il reindirizzamento tramite helper rails
            $.ajax({
              url: '/events/'+ event_id +'/evaluations/'+ intValue,
              method: 'POST',
              dataType: 'html',
              headers: {
                'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content'),
                Accept: 'text/html'

              },
              success: function(response) {
                console.log("Reindirizzamento avvenuto con successo\n");
                window.location.href = '/events';


              },
             
              error: function(xhr) {
                // Gestisci eventuali errori nella chiamata AJAX
                console.log(xhr);
                console.log('Errore nella richiesta AJAX');
                console.log('Status:', xhr.status);
                console.log('Response:', xhr.responseText);
                
              }
            });
            }
          }
            
        
        sendButton.addEventListener("click",Valuta);

      
        //ripristino i bottoni quando premo valuta
       function Ripristina(){
        console.log("Sono in ripristina");
        const stars = document.querySelectorAll('.rating input[type="radio"]');
        for(var i=0; i<stars.length;i++){
          if(stars[i].checked){
              stars[i].checked=false;
          }
        }
        }
        if(valuta!=null){
        valuta.addEventListener("click",Ripristina);}


      });
      
      
         


 

   