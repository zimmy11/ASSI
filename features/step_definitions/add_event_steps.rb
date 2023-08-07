# features/step_definitions/event_steps.rb

# Passaggi di supporto per il Background
Given('Sono nella pagina di sign up') do
    visit(new_user_registration_path) # Assume che la route per la pagina di login sia new_user_session_path
end   
Given('inserisco nel form username {string}') do |username|
    # Sostituisci "username" e "password" con le credenziali valide per il test
    fill_in 'user[username]', with: username
  end
  Given('inserisco nel form email {string}') do |email|
    # Sostituisci "username" e "password" con le credenziali valide per il test
    fill_in 'user[email]', with: email
  end
  Given('inserisco nel form ruolo {string}') do |role|
    # Sostituisci "username" e "password" con le credenziali valide per il test
    choose 'user[role]', option: role
  end
  
  Given('inserisco nel form password {string}') do |password|
    fill_in 'user[password]', with: password
  end
  Given('inserisco nel form conferma password {string}') do |password|
    fill_in 'user[password_confirmation]', with: password
  end
  When('clicco su Sign Up') do

    find('input[type="submit"][value="Sign up"]').click

end
  
  Then('dovrei essere reindirizzato alla homepage') do
    
    expect(page).to have_content("EventMaster") # Sostituisci con la route per la pagina del dashboard
  end
  
  When('clicco sul pulsante +') do 
    puts page.html
    link = find('a[href="/events/new"]')
    link.click
end

  Then('dovrei essere reindirizzato alla pagina di creazione dell\'evento') do
     # Assumi che la route per la pagina di creazione di un nuovo evento sia new_event_path
    puts page.html
    expect(current_path).to eq(new_event_path)
  end
  
  # Passaggi di supporto per lo Scenario
  When('ho riempito il form nuovo evento con titolo {string}') do |title|
    
    fill_in "event[title]", with: title
  end
  
  And('inserisco la data {string}') do |date|
    fill_in 'event[date]', with: date
  end
  
  And('inserisco la location {string}') do |location|
    fill_in 'event[location]', with: location
  end
  
  And('inserisco il prezzo {int}') do |price|
    fill_in 'event[price]', with: price
  end
  
  And('premo su {string}') do |button|
    click_button button
  end
  
  Then("l'evento dovrebbe essere pubblicato") do
    @event = Event.last
    expect(@event.status).to eq("published")
  end
  
  And("il limite di partecipanti all'evento non dovrebbe essere null") do
    expect(@event.limit).not_to be_nil
  end
  
  And("le prevendite rimaste all'evento dovrebbero essere pari al limite di partecipanti") do
    expect(@event.presales_left).to eq(@event.limit)
  end
  
  And("il valore medio dell'evento dovrebbe essere pari a {float}") do |avgvalue|
    expect(@event.avgvalue).to eq(avgvalue)
  end
  Then('la pagina dovrebbe avere tra gli errori {string}') do |error|
    expect(page).to have_content(error)
  end
  