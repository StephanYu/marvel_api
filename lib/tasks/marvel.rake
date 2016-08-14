namespace :marvel do 

  desc "Save comics to the database"
  task :save_comics => :environment do 
    ImportComicsService.new.import
  end

  desc "Save comic characters to the database"
  task :save_characters => :environment do 
    ImportCharactersService.new.import
  end
end
