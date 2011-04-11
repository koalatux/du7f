class Choice < ActiveRecord::Base
  attr_accessible :title
  #validates_presence_of :poll # TODO
  validates_associated :entries

  belongs_to :poll
  has_many :entries, :dependent => :destroy

  def count_answers(option)
    self.entries.count( :conditions => { "entries.answer" => option } )
  end
end
