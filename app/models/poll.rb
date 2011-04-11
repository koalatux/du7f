class Poll < ActiveRecord::Base
  before_create :set_tokens

  attr_accessible :author, :title, :description, :choices_attributes
  validates_presence_of :author, :title, :description #, :poll_type

  has_many :choices, :dependent => :destroy
  has_many :participants, :dependent => :destroy
  accepts_nested_attributes_for :choices

  def to_param
    self.token
  end

  def options
    # TODO: depends on poll_type
    {0 => "no", 1 => "yes", 2 => "maybe"}
  end

  private

  def set_tokens
    self.token = ActiveSupport::SecureRandom.hex(16)
    self.admin_token = ActiveSupport::SecureRandom.hex(16)
  end
end
