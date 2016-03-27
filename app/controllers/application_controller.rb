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


class ApplicationController < ActionController::Base
  before_filter :get_poll

  private

  def get_poll
    @poll = Poll.includes(:choices).order('choices.id').find_by!(token: params[:token])
  end

  def get_poll_associates
    # OPTIMIZE: do a select for only the needed columns
    @participants = Participant.includes(entries: :choice).where(poll_id: @poll.id).order('participants.id', 'choices.id')
    # TODO: eager loading for counts
    @comments = Comment.where(poll_id: @poll.id).order(:created_at)
  end

  def verify_admin_token
    raise ActiveRecord::RecordNotFound if @poll.admin_token != params[:admin_token]
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
