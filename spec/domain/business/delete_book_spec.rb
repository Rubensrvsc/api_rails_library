# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Business::DeleteBook do
  before(:each) do
    @book = create(:book)
  end
  context 'delete book' do
    it { expect(Book.count).to eq(1) }

    it 'delete book' do
      described_class.new.call(id_book: @book.id)
      expect(Book.count).to eq(0)
    end
  end
end
