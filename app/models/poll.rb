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

  POLL_TYPES = {
    1 => {
      :name => "Yes/No",
      :answers => {
        1 => { :name => "yes", :color => "#7fff7f" },
        3 => { :name => "no", :color => "#ff7f7f" }
      }
    },
    2 => {
      :name => "Yes/No/Maybe",
      :answers => {
        1 => { :name => "yes", :color => "#7fff7f" },
        2 => { :name => "maybe", :color => "#ffffff" },
        3 => { :name => "no", :color => "#ff7f7f" }
      }
    }
  }

  before_create :set_tokens!

  attr_accessor :enable_close_at
  attr_accessible :author, :title, :description, :admin_email_address, :poll_type, :comments_allowed, :choices_attributes, :close_at, :enable_close_at
  attr_readonly :poll_type
  validates_presence_of :author, :title, :description, :poll_type
  # validate presence of :token and :admin_token # TODO
  #validates_associated :choices, :participants # TODO
  validate :must_have_at_least_one_choice
  validate :must_have_nil_or_valid_admin_email_address
  validate :must_be_valid_poll_type

  has_many :choices, :dependent => :destroy
  has_many :participants, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  accepts_nested_attributes_for :choices

  def to_param
    self.token
  end

  def answer_set
    POLL_TYPES[poll_type] && POLL_TYPES[poll_type][:answers]
  end

  def destroy_empty_choices!
    self.choices.each do |choice|
      choice.destroy if choice.title.blank?
    end
  end

  def close_at
    self[:close_at] && self[:close_at].getlocal || Time.now
  end

  def close_at=(value)
    @disable_close_at || self[:close_at] = value
  end

  def enable_close_at
    !!self[:close_at]
  end

  def enable_close_at=(value)
    @disable_close_at = !ActiveRecord::ConnectionAdapters::Column::value_to_boolean(value)
    if @disable_close_at
      self[:close_at] = nil
    else
      self[:close_at] ||= Time.at(0)
    end
  end

  def open?
    not enable_close_at && (close_at.utc <= Time.now.utc)
  end

  private

  def set_tokens!
    self.token = ActiveSupport::SecureRandom.hex(16)
    self.admin_token = ActiveSupport::SecureRandom.hex(16)
  end

  def must_have_at_least_one_choice
    self.errors.add(:choices, "count must be at least one") if
      self.choices.find_all{|x| !x.destroyed?}.size == 0
  end

  def must_have_nil_or_valid_admin_email_address
    self.admin_email_address = nil if self.admin_email_address.blank?
    if self.admin_email_address
      self.errors.add(:admin_email_address, "must be valid or empty") unless
        self.admin_email_address.match(/.@./) # TODO: RFC 3696
    end
  end

  def must_be_valid_poll_type
    self.errors.add(:poll_type, :invalid) unless
      POLL_TYPES[poll_type]
  end

end
