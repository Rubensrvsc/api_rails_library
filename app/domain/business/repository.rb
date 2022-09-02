# frozen_string_literal: true

module Business
  class Repository
    def all_books
      Book.all.select(:name_book, :pages)
    end
  end
end
