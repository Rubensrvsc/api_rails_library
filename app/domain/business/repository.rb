# frozen_string_literal: true

module Business
  class Repository
    def all_books
      Book.all.select(:name_book, :pages)
    end

    def find_by_id(id_book:)
      Book.find_by(id: id_book)
    end
  end
end
