FactoryBot.define do
  factory :insult_session do
    name { "Don Rickles" }
    game { "Mario" }
    death_counter { 0 }

    factory :started_session do
      started_at { 5.minutes.ago }
    end
  end
end
