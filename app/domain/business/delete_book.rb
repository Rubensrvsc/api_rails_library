# frozen_string_literal: true

require 'dry/monads'

module Business
  class DeleteBook
    include Dry::Monads[:result, :do]

    def call(id_book:)
      book_deleted = yield delete_book(id_book: id_book)

      Success(book_deleted)
    end

    def delete_book(id_book:)
      book = Book.find_by(id: id_book).destroy

      Success(book)
    end
  end
end
