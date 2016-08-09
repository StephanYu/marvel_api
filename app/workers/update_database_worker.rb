class UpdateDatabaseWorker
  include Sidekiq::Worker

  def perform
    # update comics and characters 
  end
end