// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails


import "@hotwired/turbo-rails"
import "controllers"
import * as bootstrap from "bootstrap"
import $ from "jquery"
$(() => {
    $('.fas').on("click",function(){
              console.log("ciao");
              var buttons =document.querySelectorAll(".fas");
              // Verifica se il bottone ha la classe "text-primary" (viola)
              for(var i=0;i<buttons.length;i++){
              if ($(buttons[i]).css("color") == "rgb(156, 131, 185)") {
                // Rendi il bottone nero
                $(buttons[i]).css("color","rgb(0,0,0)");
              }
            }
              
                // Rendi il bottone viola
            
            $(this).css("color","rgb(156, 131, 185)");
              
            });
          });




 

   