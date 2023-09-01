# File: add_event_no_login_steps.rb
Given('sono nella newpage dell\'applicazione da utente non loggato') do
    visit(new_event_path)
    
end
Then('la pagina corrente dovrebbe essere la pagina di log_in') do
   expect(current_path).to eq(new_user_session_path)
end

When('clicco su Logout') do
    # Utilizziamo Capybara per simulare il clic sul link con l'id "logout-button"
    find('#logout-button').click
  end
  
  Then('dovrei essere reindirizzato alla pagina di Log in') do
    expect(current_path).to satisfy { |path| path == '/users/sign_in'}
  end
  
  When('clicco sul pulsante Forgot your password') do
    click_link('Forgot your password?', id: 'forgot-password-link')
  end
  
  
  Then('dovrei essere reindirizzato alla pagina di recupero della password') do
    expect(current_path).to satisfy { |path| path == '/users/password/new'}
  end
  
  When('clicco sul pulsante Log in') do
    click_link('Log in', id: 'login-button')
  end
  
  
  When('clicco sul pulsante Sign up') do
    click_link('Sign up', id: 'sign-up-button')
  end
  
  
  Then('dovrei essere reindirizzato alla pagina di Sign up') do
    expect(current_path).to satisfy { |path| path == '/users/sign_up'}
  end
  
  When('ho riempito il form di sign in con email {string}') do |string|
    pending # Write code here that turns the phrase above into concrete actions
  end
  
  When('inserisco la password {string}') do |string|
    pending # Write code here that turns the phrase above into concrete actions
  end

  