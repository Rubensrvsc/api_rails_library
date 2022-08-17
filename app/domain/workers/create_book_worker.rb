
module Workers
    class CreateBookWorker
        include Sidekiq::Worker
        sidekiq_options retry: false

      def perform(name_book, pages)
        Book.create!(name_book:, pages:)
      end
    end
end
