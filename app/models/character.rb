class Character < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :system_message, presence: true

  has_many :messages
end
