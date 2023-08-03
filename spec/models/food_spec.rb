require 'rails_helper'

RSpec.describe Food, type: :model do
  before :each do
    @user = User.create(name: 'Test', email: 'test3@gmail.com', password: 123_456, password_confirmation: 123_456)
  end
  context 'validations' do
    it 'is valid with valid attributes' do
      food = Food.new(name: 'Rice', measurement_unit: 'gram', price: 20, quantity: 11, user: @user)
      expect(food).to be_valid
    end

    it 'is not valid without a name' do
      food = Food.new(name: nil, measurement_unit: 'gram', price: 20, quantity: 11, user_id: @user.id)
      expect(food).to_not be_valid
    end

    it 'is not valid without price' do
      food = Food.new(name: 'Rice', measurement_unit: 'gram', price: nil, quantity: 11, user_id: @user.id)
      expect(food).to_not be_valid
    end

    it 'is not valid without user id' do
      food = Food.new(name: 'Rice', measurement_unit: 'gram', price: 20, quantity: 11, user_id: nil)
      expect(food).to_not be_valid
    end
  end

  context 'associations' do
    it 'has_many recipes' do
      t = Food.reflect_on_association(:recipes)
      expect(t.macro).to eq :has_many
    end
    it 'belongs_to user' do
      t = Food.reflect_on_association(:user)
      expect(t.macro).to eq :belongs_to
    end
  end
end
