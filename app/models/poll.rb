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


class Poll < ActiveRecord::Base
  before_create :set_tokens!

  attr_accessible :author, :title, :description, :choices_attributes
  validates_presence_of :author, :title, :description #, :poll_type
  #validates_associated :choices, :participants # TODO
  validate :must_have_at_least_one_choice

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

  def destroy_empty_choices!
    self.choices.each do |choice|
      choice.destroy if choice.title.blank?
    end
  end

  private

  def set_tokens!
    self.token = ActiveSupport::SecureRandom.hex(16)
    self.admin_token = ActiveSupport::SecureRandom.hex(16)
  end

  def must_have_at_least_one_choice
    self.errors.add(:choices, "count must be at least one") if
      self.choices.find_all{|x| !x.destroyed?}.count == 0
  end

end
