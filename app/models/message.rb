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

  # Because ChatGPT limits conversation history by token size,
  # we need an easy way to find how much context we can include
  # within that limit
  def self.from_desc_token_sum
    from <<-SQL.strip_heredoc
      (
        SELECT *, 
        SUM(tokens) OVER (
          PARTITION BY character_id
          ORDER BY id DESC
        ) AS from_recent_token_sum
        FROM messages
      ) AS messages
    SQL
  end
end
