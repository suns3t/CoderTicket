class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  belongs_to :user
  has_many :ticket_types, dependent: :destroy
  has_many :orders, dependent: :destroy
  
  validates_presence_of :extended_html_description, :venue, :category, :starts_at, :name
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  scope :current_event, -> { where("starts_at >= ?", Time.now) }
  scope :sort, -> { order("starts_at ASC")}
  scope :published, -> { where("published_at IS NOT NULL")}

  validate :starts_at_happen_in_future
  validate :ends_at_later_than_starts_at

  def starts_at_happen_in_future
    if (starts_at.comparable_time < Time.zone.now)
      errors.add(:starts_at, "Event should start in the future")
    end
  end

  def ends_at_later_than_starts_at
    if (starts_at.comparable_time > ends_at.comparable_time)    
      errors.add(:ends_at, "Ends_at should be later than starts_at")
    end
  end

  def self.search(params)
    if params
      where("upper(name) LIKE '%#{params.upcase}%'")
    else
      all
    end
  end
end
