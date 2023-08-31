class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    def after_sign_in_path_for(resource)
        if resource && resource.banned?
          sign_out resource
          flash[:error] = "Il tuo account è stato sospeso. Contatta l'amministratore per ulteriori informazioni."
          new_user_session_path
        end
    end
 

end
