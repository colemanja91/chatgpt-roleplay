class Summary < ApplicationRecord
  belongs_to :character

  validates :content, presence: true

  before_save do
    self.tokens = OpenAI.rough_token_count(content)
  end
end
