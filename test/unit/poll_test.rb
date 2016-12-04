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


require 'test_helper'

class PollTest < ActiveSupport::TestCase

  def setup
    @poll = Poll.new(author: 'bob', title: 'test', description: 'foo bar baz', calculation: '23', poll_type: 1)
    @choice = add_choice 'foo'
  end

  def add_choice(title)
    choice = Choice.new(title: title)
    choice.poll = @poll
    @poll.choices << choice
    choice
  end

  test 'poll is valid and gets tokens' do
    assert @poll.save

    assert @poll.token
    assert_equal @poll.token, @poll.to_param

    assert @poll.admin_token
    assert_not_equal @poll.token, @poll.admin_token
  end

  test 'poll without choices is invalid' do
    @poll.choices = []
    assert !@poll.save
  end

  test 'valid email' do
    @poll.admin_email_address = 'alice@example.org'
    assert @poll.save
  end

  test 'invalid email' do
    @poll.admin_email_address = 'invalid'
    assert !@poll.save
    @poll.admin_email_address = 'invalid@'
    assert !@poll.save
    @poll.admin_email_address = '@example.com'
    assert !@poll.save
  end

  test 'invalid poll type' do
    @poll.poll_type = 1337
    assert !@poll.save
  end

  test 'answer set' do
    assert_equal({1 => {color: '#7fff7f', name: 'yes'}, 3 => {color: '#ff7f7f', name: 'no'}}, @poll.answer_set)
    @poll.poll_type = 2
    assert_equal({1 => {color: '#7fff7f', name: 'yes'}, 2 => {color: '#ffffff', name: 'maybe'}, 3 => {color: '#ff7f7f', name: 'no'}}, @poll.answer_set)
    @poll.poll_type = 1337
    assert_nil @poll.answer_set
  end

  test 'destroy empty choices' do
    add_choice nil
    add_choice ''
    assert_equal 3, @poll.choices.size
    @poll.destroy_empty_choices!
    assert @poll.save
    @poll.reload
    assert_equal 1, @poll.choices.size
  end

  test 'close at' do
    time = 2.days.ago
    @poll.close_at = time
    assert !@poll.enable_close_at
    assert_equal time, @poll.close_at
    @poll.enable_close_at = '1'
    assert @poll.enable_close_at
    assert_equal time, @poll.close_at

    @poll.enable_close_at = nil
    assert !@poll.enable_close_at
    assert_equal time, @poll.close_at
    @poll.enable_close_at = '1'
    assert @poll.enable_close_at
    assert_equal time, @poll.close_at
  end

  test 'close at after enabling' do
    time = 2.days.ago
    @poll.enable_close_at = '1'
    assert @poll.enable_close_at
    @poll.close_at = time
    assert @poll.enable_close_at
    assert_equal time, @poll.close_at

    @poll.enable_close_at = nil
    assert !@poll.enable_close_at
    assert_equal time, @poll.close_at
    @poll.enable_close_at = '1'
    assert @poll.enable_close_at
    assert_equal time, @poll.close_at
  end

  test 'close at when closing disabled' do
    time = Time.now
    assert !@poll.enable_close_at
    close_time = @poll.close_at
    assert close_time >= time && close_time <= Time.now
    @poll.enable_close_at = '1'
    assert @poll.enable_close_at
    assert @poll.close_at
  end

  test 'open' do
    assert @poll.open?
    @poll.close_at = 1.minute.ago
    @poll.enable_close_at = '1'
    assert !@poll.open?
    @poll.close_at = 1.minute.from_now
    assert @poll.open?
  end

  test 'title_in_quotes' do
    assert_equal ' "test"', @poll.title_in_quotes

    @poll.title = ''
    assert_equal '', @poll.title_in_quotes
  end

  test 'winner_choices' do
    @choice.stubs(:count_answers).with(3).returns(2)
    my_choice = add_choice 'bar'
    my_choice.stubs(:id).returns(:my_choice)
    my_choice.stubs(:count_answers).with(3).returns(1)
    assert_equal [:my_choice], @poll.winner_choices
  end

  test 'winner_choices_with_poll_type_2' do
    @poll.poll_type = 2
    @choice.stubs(:count_answers).with(3).returns(2)
    @choice.stubs(:count_answers).with(2).returns(1)
    my_choice = add_choice 'bar'
    my_choice.stubs(:id).returns(:my_choice)
    my_choice.stubs(:count_answers).with(3).returns(2)
    my_choice.stubs(:count_answers).with(2).returns(0)
    assert_equal [:my_choice], @poll.winner_choices
  end

  test 'winner_choices_with_one_choice' do
    assert_equal [], @poll.winner_choices
  end

  test 'winner_choices_with_unanswered_choices' do
    @choice.stubs(:participants).returns(0...5)
    @choice.stubs(:entries).returns(0...5)
    @choice.stubs(:count_answers).with(3).returns(2)
    my_choice = add_choice 'bar'
    my_choice.stubs(:id).returns(:my_choice)
    my_choice.stubs(:participants).returns(0...5)
    my_choice.stubs(:entries).returns(0...3)
    my_choice.stubs(:count_answers).with(3).returns(1)
    assert_equal [], @poll.winner_choices
  end

  test 'honeypot_touched' do
    @poll.ubarlcbg = 'omnomnomnomnom'
    assert !@poll.save
  end

  test 'alternative_calculation' do
    @poll.calculation = '0x17'
    assert @poll.save
  end

  test 'calculation_wrong' do
    @poll.calculation = '42'
    assert !@poll.save
  end

end
