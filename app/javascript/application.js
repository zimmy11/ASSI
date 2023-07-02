// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

window.addEventListener("beforeunload", function(event) {
    var form = document.getElementById("event_form");
  
    // Verifica se il form ha valori nulli per i campi obbligatori
    var title = form.querySelector("#title").value;
    var date = form.querySelector("#date").value;
    
    if (title.trim() === "" || date.trim() === "") {
   
      event.returnValue = "Compila i campi obbligatori: Titolo e Data.";
    }
  });
  


  
