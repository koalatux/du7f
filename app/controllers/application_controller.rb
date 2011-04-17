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


# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password


  before_filter :get_poll

  private

  def get_poll
    @poll = Poll.find_by_token(params[:token]) or raise ActiveRecord::RecordNotFound
  end

  def get_poll_associates
    # OPTIMIZE: do a select for only the needed columns
    @participants = Participant.find(:all, :conditions => {:poll_id => @poll.id}, :order => "participants.id, choices.id", :include => {:entries => :choice})
    # TODO: eager loading for counts
    @choices = Choice.find(:all, :conditions => {:poll_id => @poll.id}, :order => "id")
  end

  def verify_admin_token
    raise ActiveRecord::RecordNotFound if @poll.admin_token != params[:admin_token]
  end

end
