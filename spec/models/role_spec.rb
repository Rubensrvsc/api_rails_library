require 'rails_helper'

RSpec.describe Role, type: :model do
  before(:each) do
    @role = Role.create!(
        type_role: 'client'
      )
    end

    context 'testing user model' do
      it { expect(Role.count).to eq(1) }

      it { expect(Role.first.type_role).to eq(@role.type_role) }
    end
end
