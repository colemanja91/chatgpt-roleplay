FactoryBot.define do
  factory :insult_session_message do
    content { "Oh my, you are really bad at this game" }
    insult_session
    insult_session_character
  end
end
