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

class EmailNotifierTest < ActionMailer::TestCase
  #test "poll_created" do
  #  @expected.subject = 'EmailNotifier#poll_created'
  #  @expected.body    = read_fixture('poll_created')
  #  @expected.date    = Time.now

  #  assert_equal @expected.encoded, EmailNotifier.create_poll_created(@expected.date).encoded
  #end

  #test "poll_changed" do
  #  @expected.subject = 'EmailNotifier#poll_changed'
  #  @expected.body    = read_fixture('poll_changed')
  #  @expected.date    = Time.now

  #  assert_equal @expected.encoded, EmailNotifier.create_poll_changed(@expected.date).encoded
  #end

  #test "participant_created" do
  #  @expected.subject = 'EmailNotifier#participant_created'
  #  @expected.body    = read_fixture('participant_created')
  #  @expected.date    = Time.now

  #  assert_equal @expected.encoded, EmailNotifier.create_participant_created(@expected.date).encoded
  #end

  #test "participant_changed" do
  #  @expected.subject = 'EmailNotifier#participant_changed'
  #  @expected.body    = read_fixture('participant_changed')
  #  @expected.date    = Time.now

  #  assert_equal @expected.encoded, EmailNotifier.create_participant_changed(@expected.date).encoded
  #end

  #test "participant_deleted" do
  #  @expected.subject = 'EmailNotifier#participant_deleted'
  #  @expected.body    = read_fixture('participant_deleted')
  #  @expected.date    = Time.now

  #  assert_equal @expected.encoded, EmailNotifier.create_participant_deleted(@expected.date).encoded
  #end
end
