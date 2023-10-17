class InsultCronJob
  include Sidekiq::Job

  def perform
    InsultCronService.new.run!
  end
end
