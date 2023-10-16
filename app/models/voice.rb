class Voice < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :xi_voice_id, presence: true
  validates :xi_similarity_boost, presence: true
  validates :xi_stability, presence: true
  validates :xi_style, presence: true

  has_many :characters
end
