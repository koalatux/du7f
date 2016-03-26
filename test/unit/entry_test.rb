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

class EntryTest < ActiveSupport::TestCase

  def setup
    @poll = Poll.new(author: 'bob', title: 'test', description: 'foo bar baz', poll_type: 1)
    @choice = Choice.new(title: 'foo')
    @choice.poll = @poll
    @participant = Participant.new(name: 'joey')
    @participant.poll = @poll
    @entry = Entry.new(answer: 1)
    @entry.choice = @choice
    @entry.participant = @participant
  end

  test 'valid entry' do
    assert @entry.save
  end

  test 'particpant poll and choice poll must match 1' do
    @entry.choice = choices(:margherita)
    assert !@entry.save
  end

  test 'particpant poll and choice poll must match 2' do
    @entry.participant = participants(:alice)
    assert !@entry.save
  end

  test 'invalid entry' do
    @entry.answer = 2
    assert !@entry.save
  end

end
