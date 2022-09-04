# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Business::Repository do
  before(:each) do
    create_list(:book, 10)
    @repository = described_class.new
  end
  context 'repository' do
    it { expect(@repository.all_books.size).to eq(10) }
  end
end
