class InsultSessionCharacter < ApplicationRecord
  validates :description, presence: true

  belongs_to :insult_session
  belongs_to :voice, optional: true
end
