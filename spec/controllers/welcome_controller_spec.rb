require 'rails_helper'

describe 'BookController' do
  context 'teste de primero rspec' do
    let!(:b) { create(:book) }
    it { expect(2 - 1).to eq(1) }
  end
end
