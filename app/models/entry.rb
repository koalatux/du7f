class Entry < ActiveRecord::Base
  attr_accessible :answer, :choice_id
  validates_presence_of :participant, :choice, :answer
  validate :particpant_poll_and_choice_poll_must_match

  belongs_to :participant
  belongs_to :choice

  # uniqueness is checked in the index table of the db
  def particpant_poll_and_choice_poll_must_match
    errors.add_to_base("participant and choice are in different polls") if self.participant.poll_id != self.choice.poll_id
  end
end
