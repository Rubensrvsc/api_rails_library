module Container
    MyContainer = Dry::Container.new
    
    MyContainer.register(:repo) { Business::Repository.new }

    Import = Dry::AutoInject(MyContainer)
end