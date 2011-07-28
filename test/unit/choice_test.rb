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

class ChoiceTest < ActiveSupport::TestCase

  test "valid_choice" do
    poll = Poll.new(:author => "bob", :title => "test", :description => "foo bar baz", :poll_type => 1)
    choice = Choice.new(:title => "foo")
    choice.poll = poll
    assert choice.save
  end

  test "count_answers" do
    margherita = choices(:margherita)
    assert_equal [1,1,0], [1,2,3].map{|x| margherita.count_answers(x)}
    weizen = choices(:weizen)
    assert_equal [1,1], [1,3].map{|x| weizen.count_answers(x)}
  end

end
