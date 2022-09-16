require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @role = create(:role)
    @user = User.create!(
        name: Faker::Name.name,
        username: Faker::Name.name,
        email: Faker::Internet.email,
        password: 'wxcvbn',
        role_id: @role.id
      )
    end

    context 'testing user model' do
      it { expect(User.count).to eq(1) }

      it { expect(User.first.name).to eq(@user.name) }
    end
end
