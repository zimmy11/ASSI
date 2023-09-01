# File: add_event_no_login_steps.rb
Given('sono nella newpage dell\'applicazione da utente non loggato') do
    visit(new_event_path)
    
end

When('clicco sul tasto di Logout') do
    find('#logout-button').click
  end

  Then('dovrei essere reindirizzato alla pagina del Profilo') do
    expect(current_path).to match(%r{/users/\d+}) # Verifica che il percorso contenga /users/ seguito da un numero (l'ID dell'utente)
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
  
  When('clicco sul pulsante di Log in') do
    find('#login-button').click
  end
  
  
  When('clicco sul pulsante Sign up') do
    click_link('Sign up', id: 'sign-up-button')
  end
  
  
  Then('dovrei essere reindirizzato alla pagina di Sign up') do
    expect(current_path).to satisfy { |path| path == '/users/sign_up'}
  end
  
  When('riempio il form di log in con email {string}') do |string|
    fill_in 'user[email]', with: string
  end
  
  When('clicco su log in') do
    click_button('Log in') # Clicca sul pulsante con il testo "Log in"
  end
  
  
  When('inserisco nel form l\'email {string}') do |string|
    fill_in 'user[email]', with: string
  end
  
  When('inserisco nel form la password {string}') do |string|
    fill_in 'user[password]', with: string
  end

  Then('dovrei vedere il messaggio "invalid username or password"') do
    expect(page).to have_content("Invalid Email or password")
  end
  
  And('dovrei vedere il mio ruolo come "admin"') do
    expect(page).to have_content("Ruolo: admin") # Assicurati che il testo corrisponda alla visualizzazione del ruolo
  end

  And('dovrei vedere il mio ruolo come "user"') do
    expect(page).to have_content("Ruolo: user") # Assicurati che il testo corrisponda alla visualizzazione del ruolo
  end

  And('dovrei vedere il mio ruolo come "organizer"') do
    expect(page).to have_content("Ruolo: organizer") # Assicurati che il testo corrisponda alla visualizzazione del ruolo
  end
  
  And('dovrebbe esserci un elemento con id "acquista-premium-link"') do
    expect(page).to have_selector('#acquista-premium-link')
  end

  And('non dovrebbe esserci più l\'elemento con id "acquista-premium-link"') do
    expect(page).not_to have_selector('#acquista-premium-link')
  end

  And('dovrebbe esserci un elemento con id "crea-evento-button"') do
    expect(page).to have_selector('#crea-evento-button')
  end
 
  And('non dovrebbe esserci più l\'elemento con id "crea-evento-button"') do
  expect(page).not_to have_selector('#crea-evento-button')
end

  