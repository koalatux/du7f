class Choice < ActiveRecord::Base
  attr_accessible :title

  belongs_to :poll
end
