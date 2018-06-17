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

class Poll < ApplicationRecord

  POLL_TYPES = {
      1 => {
          name: 'Yes/No',
          answers: {
              1 => {name: 'yes', color: '#7fff7f'},
              3 => {name: 'no', color: '#ff7f7f'}
          }
      },
      2 => {
          name: 'Yes/No/Maybe',
          answers: {
              1 => {name: 'yes', color: '#7fff7f'},
              2 => {name: 'maybe', color: '#ffffff'},
              3 => {name: 'no', color: '#ff7f7f'}
          }
      }
  }

  before_create :set_tokens!

  attr_readonly :poll_type
  validates_presence_of :poll_type
  validates_associated :choices
  validates_email_format_of :admin_email_address, check_mx: true, allow_nil: true
  validate :must_have_at_least_one_choice
  validate :must_be_valid_poll_type
  validate :honeypot_must_be_untouched
  validate :calculation_must_be_correct

  has_many :choices, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :choices

  def to_param
    self.token
  end

  def title_in_quotes
    if self.title && !self.title.blank?
      " \"#{self.title}\""
    else
      ''
    end
  end

  def answer_set
    POLL_TYPES[poll_type] && POLL_TYPES[poll_type][:answers]
  end

  def destroy_empty_choices!
    self.choices.each do |choice|
      choice.destroy if choice.title.blank?
    end
  end

  def admin_email_address=(value)
    value = nil if value.blank?
    self[:admin_email_address] = value
  end

  def close_at
    self[:close_at] && self[:close_at].getlocal || @close_at || Time.now
  end

  def close_at=(value)
    if enable_close_at
      self[:close_at] = value
    else
      @close_at = value
    end
  end

  def enable_close_at
    !!self[:close_at]
  end

  def enable_close_at=(value)
    if ActiveRecord::Type::Boolean.new.cast(value)
      self[:close_at] ||= @close_at || Time.at(0)
    else
      @close_at = self[:close_at]
      self[:close_at] = nil
    end
  end

  def open?
    not enable_close_at && (close_at.utc <= Time.now.utc)
  end

  def winner_choices
    return @winner_choices if @winner_choices

    # no winner if there are unanswered choices
    self.choices.each do |c|
      if c.entries.size != self.participants.size
        @winner_choices = []
        return []
      end
    end

    # filter choices for the winner, begin with the worst answer and select choices with the lowest count
    win = self.choices
    answers = [3] # TODO: integrate this in poll_type model eventually
    answers << 2 if self.poll_type == 2
    answers.each do |i|
      min = win.map { |c| c.count_answers(i) }.min
      win = win.select { |c| c.count_answers(i) == min }
    end

    win = [] if win.size == self.choices.size
    win = win.map { |c| c.id }

    @winner_choices = win
  end

  def ubarlcbg
    @honeypot
  end

  def ubarlcbg=(value)
    @honeypot = value
  end

  def calculation
    @calculation
  end

  def calculation=(value)
    @calculation = value
  end

  private

  def create_token
    # 16 bytes of random data encoded as base64url without padding
    SecureRandom.base64(16)[0...22].tr('+/', '-_')
  end

  def set_tokens!
    self.token = create_token
    self.admin_token = create_token
  end

  def must_have_at_least_one_choice
    self.errors.add(:choices, 'count must be at least one') if self.choices.find_all { |x| !x.destroyed? }.size == 0
  end

  def must_be_valid_poll_type
    self.errors.add(:poll_type, :invalid) unless POLL_TYPES[poll_type]
  end

  def honeypot_must_be_untouched
    self.errors.add(:base, 'nope!') unless ubarlcbg.blank?
  end

  def calculation_must_be_correct
    self.errors.add(:base, 'nope!') unless %w(23 0x17).include? calculation
  end

end
