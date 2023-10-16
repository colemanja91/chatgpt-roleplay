FactoryBot.define do
  factory :character do
    name { "Awesome Character" }
    system_message { "You are a ChatBot" }
    voice { nil }
  end
end
