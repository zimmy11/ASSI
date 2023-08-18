class ApplicationController < ActionController::Base
    before_action :check_banned
    private

    def check_banned
      if current_user && Ban.where(user_id: current_user.id).exists?
        flash[:error] = "Il tuo account è stato sospeso. Contatta l'amministratore per ulteriori informazioni."
        redirect_to new_user_session_path
      end
    end
end
