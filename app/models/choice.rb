class Choice < ActiveRecord::Base
  attr_accessible :title
  validates_associated :entries

  belongs_to :poll
  has_many :entries, :dependent => :destroy

  def result
    res = {}
    self.poll.options.each do |option|
      #res[option] = self.entries.to_a.count{ |e| e.answer == option }
      res[option] = self.entries.count( :conditions => { "entries.answer" => option } )
    end
    res
  end
end
