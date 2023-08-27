require 'rails_helper'

RSpec.describe Event, type: :model do
  context "Attributes" do
  it "should not save event with no attributes" do
  event = Event.new
  expect(event).not_to be_valid
  end

  it 'should have a title attribute' do
    event=Event.new
    expect(event).to respond_to(:title)
  end
  it "should be invalid without a title" do
    User.create(id:1,username: "zimmy",role:"organizer",password:"ooo1232fvg",email:"testexample@gmail.com")
    event = Event.new(location: "Roma", date: "2024-09-21", price: 15, organizer_id: 1,status: "published")
    expect(event).not_to be_valid
    expect(event.errors[:title]).to include("can't be blank")
  end
  it 'should have a date attribute' do
    event=Event.new
    expect(event).to respond_to(:date)
  end
  it "should be invalid without  a date" do
    User.create(id:1,username: "zimmy",role:"organizer",password:"ooo1232fvg",email:"testexample@gmail.com")
    event = Event.new(title: "Jardin", location: "Roma", price: 15, organizer_id: 1,status: "published")
    expect(event).not_to be_valid
    expect(event.errors[:date]).to include("can't be blank")
  end
  it "should be invalid date is not after today's date " do
    User.create(id:1,username: "zimmy",role:"organizer",password:"ooo1232fvg",email:"testexample@gmail.com")
    event = Event.new(title: "Jardin", location: "Roma",date: "2022-09-30", price: 15, organizer_id: 1,status: "published")
    expect(event).not_to be_valid
    expect(event.errors["Data"]).to include("deve essere maggiore della data odierna")
  end
  it 'should have a location attribute' do
    event=Event.new
    expect(event).to respond_to(:location)
  end
  it "should be invalid without e a location" do
    User.create(id:1,username: "zimmy",role:"organizer",password:"ooo1232fvg",email:"testexample@gmail.com")
    event = Event.new(title: "Jardin", date: "2024-09-21", price: 15, organizer_id: 1,status: "published")
    expect(event).not_to be_valid
    expect(event.errors[:location]).to include("can't be blank")
  end
  it 'should have a price attribute' do
    event=Event.new
    expect(event).to respond_to(:price)
  end
  it "should be invalid without a price" do
    User.create(id:1,username: "zimmy",role:"organizer",password:"ooo1232fvg",email:"testexample@gmail.com")
    event = Event.new(title: "Jardin", location: "Roma", date: "2024-09-21", organizer_id: 1,status: "published")
    expect(event).not_to be_valid
    expect(event.errors[:price]).to include("can't be blank")
  end
  it 'should have an organizer attribute' do
    event=Event.new
    expect(event).to respond_to(:organizer_id)
  end
  it "should be invalid without  an organizer" do
    event = Event.new(title: "Jardin", location: "Roma", date: "2024-09-21", price: 15,status: "published")
    expect(event).not_to be_valid
    expect(event.errors[:organizer_id]).to include("can't be blank")
  end
  it "should not allow two events to have the same title" do
    User.create(id:1,username: "zimmy",role:"organizer",password:"ooo1232fvg",email:"testexample@gmail.com")
    event1 = Event.create(title: "Jardin", location: "Roma", date: "2024-09-21", price: 15, organizer_id: 1,status: "published")
    event2 = Event.new(title: "Jardin", location: "Milano", date: "2024-09-21", price: 20, organizer_id: 1,status: "published")
    expect(event1).to be_valid
    expect(event2).not_to be_valid
    expect(event2.errors[:title]).to include("has already been taken")
  end

  it "should allow two events to have the same date and location" do
    User.create(id:1,username: "zimmy",role:"organizer",password:"ooo1232fvg",email:"testexample@gmail.com")
    event1 = Event.create(title: "Jardin Roma", location: "Roma", date: "2024-09-21", price: 15, organizer_id: 1,status: "published")
    event2 = Event.new(title: "Festa Roma", location: "Roma", date: "2024-09-21", price: 20, organizer_id: 1,status: "published")
    expect(event1).to be_valid
    expect(event2).to be_valid
  end
  it "should have a description attribute" do
    user= User.create(id: 1, username: "prova", role: "admin", email: "alfonso@gmail.com",password: "56&Yyy16gtf")
    event=Event.create(title: "Jardin", location: "Roma", date: "2024-09-21", price: 15, organizer_id: 1,status:"published",limit:50,description: "Evento piacevole e elegante per teenagers")
    expect(event.description).to eq("Evento piacevole e elegante per teenagers")
    expect(event).to be_valid
  end 
  it 'should have a limit attribute' do
    event=Event.new
    expect(event).to respond_to(:limit)
  end
  it "should have default limit value of 100" do
    User.create(id:1,username: "zimmy",role:"organizer",password:"ooo1232fvg",email:"testexample@gmail.com")
    event = Event.create(title: "Jardin", location: "Roma", date: "2024-09-21", price: 15, organizer_id: 1,status:"published")
    expect(event.limit).to eq(100)
    expect(event).to be_valid
  end
  it 'should have a presales_left attribute' do
    event=Event.new
    expect(event).to respond_to(:presales_left)
  end
  it "should have presales_left equal to limit by default" do
    User.create(id:1,username: "zimmy",role:"organizer",password:"ooo1232fvg",email:"testexample@gmail.com")
    event = Event.create(title: "Jardin", location: "Roma", date: "2024-09-21", price: 15, organizer_id: 1,status:"published",limit:50)
    expect(event.presales_left).to eq(event.limit)
    expect(event).to be_valid
  end
  it 'should have an avgvalue attribute' do
    event=Event.new
    expect(event).to respond_to(:avgvalue)
  end
  it "should have default average value of 0.0" do
    User.create(id:1,username: "zimmy",role:"organizer",password:"ooo1232fvg",email:"testexample@gmail.com")
    event = Event.create(title: "Jardin", location: "Roma", date: "2024-09-21", price: 15, organizer_id: 1,status:"published")
    expect(event.avgvalue).to eq(0.0)
    expect(event).to be_valid
  end
  it "should not be valid with description attribute with max length < 200" do
    User.create(id:1,username: "zimmy",role:"organizer",password:"ooo1232fvg",email:"testexample@gmail.com")
    event = Event.create(title: "Jardin", location: "Roma", date: "2024-09-21", price: 15, organizer_id: 1,status:"published",description:"Elegante serata di gala con musica dal vivo, prelibatezze culinarie e un'atmosfera affascinante.Celebrazione eccezionale: un mix straordinario di artisti, cibo delizioso e intrattenimento coinvolgente per tutti.")
    expect(event).not_to be_valid
    expect(event.errors["Descrizione"]).to include("deve essere lunga al massimo 200 caratteri") 

  end 
  it 'should have a status attribute' do
    event=Event.new
    expect(event).to respond_to(:status)
  end
  it 'should be invalid if a status attribute is not included in {draft,published}' do
    event = Event.new
    expect(event.status).not_to satisfy { |status| ['draft', 'published'].include?(status) }
  end

  it "should not save event organized by simple user" do
    user= User.create(id: 6, username: "prova", role: "user", email: "alfonso@gmail.com",password: "56&Yyy16gtf")
    event=Event.new(title: "Jardin", location: "Roma", date: "2024-09-21", price: 15, organizer_id: 6,status:"published",limit:50)
    expect(event).not_to be_valid
  end

  it "should save event organized by admin" do
    user= User.create(id: 1, username: "prova", role: "admin", email: "alfonso@gmail.com",password: "56&Yyy16gtf")
    event=Event.new(title: "Jardin", location: "Roma", date: "2024-09-21", price: 15, organizer_id: 1,status:"published",limit:50)
    expect(event).to be_valid
  end 
  







    





end

end
