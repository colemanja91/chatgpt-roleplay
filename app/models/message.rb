class Message < ApplicationRecord
  belongs_to :character

  validates :role, inclusion: ["user", "assistant"], presence: true
  validates :content, presence: true

  def api_format
    {
      role: role,
      content: content
    }
  end
end
