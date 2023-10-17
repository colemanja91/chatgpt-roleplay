class InsultSession < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :game, presence: true
  validates :death_counter, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  before_validation :set_defaults

  has_many :insult_session_characters
  has_many :insult_session_messages

  def safeguard!
    return false if ended_at.present? || started_at.nil?

    if started_at <= 3.hours.ago
      self.ended_at = Time.now
      save!
      true
    end
  end

  def start!
    self.started_at = Time.now
    self.ended_at = nil
    save!
  end

  private

  def set_defaults
    self.death_counter = 0 if death_counter.blank?
  end
end
