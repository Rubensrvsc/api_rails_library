# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Business::CreateBook do
  before(:each) do
    @book_saved = described_class.new.call(name_book: 'A cabana', pages: 100)
  end
  context 'create book' do
    it { expect(@book_saved.success?).to be_truthy }

    it { expect(Book.count).to eq(1) }
  end
end
