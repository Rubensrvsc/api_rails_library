require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  context 'register' do
    let!(:role) { Role.create(type_role: 'client') }
    let(:user) do
      {
        name: Faker::Name.name,
        username: Faker::Name.name,
        email: Faker::Internet.email,
        password: 'wxcvbn'
      }
    end
    it 'confer user count' do
      post :sign_up, params: user
      expect(User.count).to eq(1)
    end

    it 'sign_up user' do
      post :sign_up, params: user
      json = JSON.parse(response.body)
      expect(json['token']).to be_a_kind_of(String)
      expect(json['user']).to eq('User created')
    end
  end

  context 'login' do
    let(:role) { create(:role) }
    let(:user) do
      User.create!(
        name: Faker::Name.name,
        username: Faker::Name.name,
        email: Faker::Internet.email,
        password: 'wxcvbn',
        role_id: role.id
      )
    end

    it 'login' do
      post :login, params: { username: user.username, password: user.password }
      json = JSON.parse(response.body)
      expect(json['token']).to be_a_kind_of(String)
    end
  end
end
