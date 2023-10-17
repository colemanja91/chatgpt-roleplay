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
    self.death_counter = 0
    save!
    InsultChatJob.perform_async(id)
  end

  def end_session!
    self.ended_at = Time.now
    save!
  end

  def add_death!
    self.death_counter += 1
    save!
    InsultChatJob.perform_async(id)
  end

  private

  def set_defaults
    self.death_counter = 0 if death_counter.blank?
  end
end
