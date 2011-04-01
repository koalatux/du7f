class Entry < ActiveRecord::Base
  attr_accessible :answer

  belongs_to :participant
end
