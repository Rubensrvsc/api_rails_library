# frozen_string_literal: true

require 'dry/monads'

module Business
  class UpdateBook
    include Dry::Monads[:result, :do]

    def call(id_book:, name_book:, pages:)
      book_saved = yield save_book(id_book:, name_book: name_book, pages: pages)

      Success(book_saved)
    end

    def save_book(id_book:, name_book:, pages:)
      book_updated = Book.find_by(id: id_book)
      book_updated.update({name_book: name_book, pages: pages})

      Success(book_updated)
    end
  end
end
