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


class Participant < ActiveRecord::Base
  validates_presence_of :poll, :name
  validates_associated :entries
  validate :number_of_entries_must_match
  validate :all_choices_must_have_entries

  belongs_to :poll
  has_many :entries, dependent: :destroy
  accepts_nested_attributes_for :entries

  private

  def number_of_entries_must_match
    if self.entries.size != self.poll.choices.size
      self.errors.add(:base, 'number of entries does not match number of choices')
    end
  end

  def all_choices_must_have_entries
    if self.poll.choices - self.entries.map{|e| e.choice} != []
      self.errors.add(:base, 'not all choices have matching entries')
    end
  end
end
