# du7f - a simple web app for simple polls
# Copyright (C) 2011  Adrian Friedli <adi@koalatux.ch>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.

# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


class Entry < ActiveRecord::Base
  attr_accessible :answer, :choice_id
  validates_presence_of :participant, :choice, :answer
  validate :particpant_poll_and_choice_poll_must_match
  validate :answer_must_be_allowed_by_poll_type
  # TODO: check uniqueness and completeness

  belongs_to :participant
  belongs_to :choice

  private

  def particpant_poll_and_choice_poll_must_match
    self.errors.add(:base, "participant and choice are in different polls") if
      self.participant && self.choice && self.participant.poll_id != self.choice.poll_id
  end

  def answer_must_be_allowed_by_poll_type
    self.errors.add(:answer, :invalid) if
      self.participant && self.participant.poll && !self.participant.poll.answer_set[self.answer]
  end

end
