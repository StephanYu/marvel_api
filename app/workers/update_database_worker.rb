class UpdateDatabaseWorker
  include Sidekiq::Worker

  def perform
    Rake::Task['marvel:save_comics'].invoke
    Rake::Task['marvel:save_characters'].invoke
  end
end