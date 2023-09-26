class Summary < ApplicationRecord
  belongs_to :character

  validates :content, presence: true
end
