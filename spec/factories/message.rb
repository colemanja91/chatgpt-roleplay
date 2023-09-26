FactoryBot.define do
  factory :message do
    content { "This is a question" }
    character

    factory :user_message do
      role { "user" }
    end

    factory :assistant_message do
      role { "assistant" }
    end
  end
end
