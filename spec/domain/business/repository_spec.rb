# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Business::Repository do
  before(:each) do
    create_list(:book, 10)
    @id_book = Book.first.id
    @repository = described_class.new
  end
  context 'repository' do
    it { expect(@repository.all_books.size).to eq(10) }

    it { expect(@repository.find_by_id(id_book: 0)).to be_nil }

    it { expect(@repository.find_by_id(id_book: @id_book)).to be_kind_of(Book) }
  end
end
