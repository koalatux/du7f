class Participant < ActiveRecord::Base
  attr_accessible :name, :entries_attributes

  belongs_to :poll
  has_many :entries, :dependent => :destroy
  accepts_nested_attributes_for :entries
end
