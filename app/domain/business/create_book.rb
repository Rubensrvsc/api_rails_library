# frozen_string_literal: true

require 'dry/monads'

module Business
  class CreateBook
    include Dry::Monads[:result, :do]

    def call(name_book:, pages:)
      book_created = yield create(name_book:, pages:)
      Success(book_created)
    end

    def create(name_book:, pages:)
      Success(Book.create!(name_book:, pages:))
    end
  end
end
