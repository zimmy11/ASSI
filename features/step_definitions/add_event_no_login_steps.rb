# File: add_event_no_login_steps.rb

Then('la pagina corrente dovrebbe essere la pagina di log_in') do
   expect(current_path).to eq(new_user_session_path)
end

When('clicco su Logout') do
    find('#logout-button').click
  end
  
  Then('dovrei essere reindirizzato alla pagina di Log in') do
    expect(current_path).to satisfy { |path| path == '/users/sign_in'}
  end
  
  When('clicco sul pulsante Log in') do
    pending # Write code here that turns the phrase above into concrete actions
  end
  
  When('clicco sul pulsante Sign in') do
    pending # Write code here that turns the phrase above into concrete actions
  end
  
  Then('dovrei essere reindirizzato alla pagina di Sign in') do
    pending # Write code here that turns the phrase above into concrete actions
  end
  
  When('ho riempito il form di sign in con email {string}') do |string|
    pending # Write code here that turns the phrase above into concrete actions
  end
  
  When('inserisco la password {string}') do |string|
    pending # Write code here that turns the phrase above into concrete actions
  end

  