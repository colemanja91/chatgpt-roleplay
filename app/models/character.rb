class Character < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :system_message, presence: true
  validates :context_size, inclusion: [0, 4096, 16000, 32000]

  has_many :messages, dependent: :destroy
  belongs_to :voice, optional: true

  before_validation :set_defaults

  before_save do
    self.system_message_tokens = OpenAI.rough_token_count(system_message)
  end

  private

  def set_defaults
    self.context_size = 4096 if context_size.blank?
  end
end
