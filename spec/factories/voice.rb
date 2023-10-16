FactoryBot.define do
  factory :voice do
    name { "Awesome Character Voice" }
    xi_voice_id { "abc123" }
    xi_similarity_boost { 0.5 }
    xi_stability { 0.5 }
    xi_style { 0.5 }
  end
end
