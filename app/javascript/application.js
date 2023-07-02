// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
//= require jquery
 import "jquery"
 import Swal from 'sweetalert2'
window.Swal=Swal
 document.addEventListener('DOMContentLoaded', () => {
   // Gestisci il flash message di errore (se presente)
   const errorMessage = document.querySelector('.error-message');
   if (errorMessage) {
     Swal.fire({
       title: 'Errore',
       text: errorMessage.textContent,
       icon: 'error',
     });
   }
 });
  
  


  
