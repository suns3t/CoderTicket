require 'rails_helper'

RSpec.describe User, type: :model do
    it "require name when sign up" do
        user = User.new
        user.email = "huyhoang@example.com"
        user.password = "123456"
        user.save
        expect(user.errors[:name]).to eq ["can't be blank"]
    end

    it "require email when sign up" do
        user = User.new
        user.name = "Hoang"
        user.password = "123456"
        user.save
        expect(user.errors[:email]).to eq ["can't be blank"]
    end

    it "require email to be unique when sign up" do
        user1 = User.create(name: "Hoang", email: "huyhoang@example.com", password: "123456")
        user2 = User.create(name: "Hoang", email: "huyhoang@example.com", password: "123456")
        expect(user2.errors[:email]).to eq ["has already been taken"]
    end
end
