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
    @poll = Poll.new(:author => "bob", :title => "test", :description => "foo bar baz", :poll_type => 1)
    @choice = Choice.new(:title => "foo")
    @choice.poll = @poll
    @poll.choices << @choice
  end

  test "poll is valid and gets tokens" do
    assert @poll.save
    assert @poll.token
    assert @poll.admin_token
  end

  test "poll without choices is invalid" do
    @poll.choices = []
    assert !@poll.save
  end

  test "valid email" do
    @poll.admin_email_address = "alice@example.org"
    assert @poll.save
  end

  test "invalid email" do
    @poll.admin_email_address = "invalid"
    assert !@poll.save
    @poll.admin_email_address = "invalid@"
    assert !@poll.save
    @poll.admin_email_address = "@example.com"
    assert !@poll.save
  end

  test "invalid poll type" do
    @poll.poll_type = 1337
    assert !@poll.save
  end

  test "answer set" do
    assert_equal({1=>{:color=>"#7fff7f", :name=>"yes"}, 3=>{:color=>"#ff7f7f", :name=>"no"}}, @poll.answer_set)
    @poll.poll_type = 2
    assert_equal({1=>{:color=>"#7fff7f", :name=>"yes"}, 2=>{:color=>"#ffffff", :name=>"maybe"}, 3=>{:color=>"#ff7f7f", :name=>"no"}}, @poll.answer_set)
    @poll.poll_type = 1337
    assert_nil @poll.answer_set
  end

  test "destroy empty choices" do
    choice = Choice.new
    choice.poll = @poll
    @poll.choices << choice
    choice = Choice.new(:title => "")
    choice.poll = @poll
    @poll.choices << choice
    assert_equal 3, @poll.choices.size
    @poll.destroy_empty_choices!
    @poll.save
    @poll.reload
    assert_equal 1, @poll.choices.size
  end

end
