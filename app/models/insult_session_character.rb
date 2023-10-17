class InsultSessionCharacter < ApplicationRecord
  validates :description, presence: true

  belongs_to :insult_session
end
