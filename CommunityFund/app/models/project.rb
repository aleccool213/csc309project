class Project < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :communities
  has_many :rewards
  has_many :funds
  accepts_nested_attributes_for :rewards, reject_if: :all_blank, allow_destroy: true

  scope :open, -> { where(open: true)}

  def initiator
    User.find(self.initiator_id)
  end

  def self.minimum_start_year
    DateTime.now.year
  end

  def self.maximum_end_year
    DateTime.now.year + 10
  end

  def description_lead
    if %w(a e i o u).member? self.communities.first.name[0].downcase
      "An"
    else
      "A"
    end
  end

  def is_initiator?(user)
    self.initiator_id == user.id
  end

  def hashtag_community(community)
    "##{community.name.gsub(/ /, "")}"
  end

  def completion_date_for_display
    "At midnight on #{completion_date.strftime('%B %m, %Y')}"
  end

  def closed?
    !open?
  end
end
