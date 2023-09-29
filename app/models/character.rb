class Character < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :system_message, presence: true

  has_many :messages, dependent: :destroy

  before_save do
    self.system_message_tokens = OpenAI.rough_token_count(system_message)
  end
end
