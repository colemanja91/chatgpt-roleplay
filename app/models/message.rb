class Message < ApplicationRecord
  belongs_to :character

  validates :role, inclusion: ["user", "assistant"], presence: true
  validates :content, presence: true

  before_save do
    self.tokens = OpenAI.rough_token_count(content)
  end

  def api_format
    {
      role: role,
      content: content
    }
  end
end
