# File: add_event_no_login_steps.rb
Given('sono nella newpage dell\'applicazione da utente non loggato') do
    visit(new_event_path)
    
end
Then('la pagina corrente dovrebbe essere la pagina di log_in') do
   expect(current_path).to eq(new_user_session_path)
end



  