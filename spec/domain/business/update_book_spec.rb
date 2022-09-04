# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Business::UpdateBook do
  before(:each) do
    @book = create(:book)
    @book_updated = described_class.new.call(id_book: @book.id, name_book: 'Novo livro', pages: 200)
  end

  context 'update book' do
    it { expect(@book_updated.success?).to be_truthy }

    it { expect(Book.find_by(id: @book.id).name_book).to eq(@book_updated.value!.name_book) }
  end
end
