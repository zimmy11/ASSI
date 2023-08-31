require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = User.new(
      username: "testuser",
      role: "user",
      email: "test@example.com",
      password: "password",
      password_confirmation: "password"
    )
    expect(user).to be_valid
  end

  it "is invalid without a username" do
    user = User.new(username: nil)
    expect(user).not_to be_valid
  end

  it "is invalid without a role" do
    user = User.new(role: nil)
    expect(user).not_to be_valid
  end

  it "is invalid without an email" do
    user = User.new(email: nil)
    expect(user).not_to be_valid
  end

  it "is invalid without a password" do
    user = User.new(password: nil, password_confirmation: "password")
    expect(user).not_to be_valid
  end

  it "is invalid if password confirmation doesn't match" do
    user = User.new(
      username: "testuser",
      role: "user",
      email: "test@example.com",
      password: "password",
      password_confirmation: "mismatched_password"
    )
    expect(user).not_to be_valid
  end

  it "is invalid if username is not unique" do
    User.create(username: "existinguser", role: "user", email: "existing@example.com", password: "password", password_confirmation: "password")
    user = User.new(username: "existinguser", role: "user", email: "newuser@example.com", password: "password", password_confirmation: "password")
    expect(user).not_to be_valid
  end

  it "is invalid if email is not unique" do
    User.create(username: "user1", role: "user", email: "existing@example.com", password: "password", password_confirmation: "password")
    user = User.new(username: "user2", role: "user", email: "existing@example.com", password: "password", password_confirmation: "password")
    expect(user).not_to be_valid
  end
end


