class InsultSessionMessage < ApplicationRecord
  validates :content, presence: true

  belongs_to :insult_session
  belongs_to :insult_session_character
end
