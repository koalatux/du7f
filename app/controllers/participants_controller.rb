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


class ParticipantsController < ApplicationController
  before_filter :get_poll_associates, :only => [ :index, :edit ]
  before_filter :get_participant, :except => [ :index, :create ]

  # TODO: ensure time stamp update, when only an entry gets changed

  # GET /0123456789abcdef...
  def index
    @participant = @poll.participants.new
    @poll.choices.each do |choice|
      @participant.entries << choice.entries.new
    end
    @participants << @participant
  end
  # index.html.erb

  def create
    @participant = @poll.participants.new(params[:participant])

    # setting the associations here is needed, because of the validation in the entries
    @participant.entries.each{ |e| e.participant = @participant }

    if @participant.save
      flash[:notice] = 'Participant was successfully created.'
      redirect_to @poll
    else
      get_poll_associates
      @participants << @participant
      render :action => "index"
    end
  end

  # edit.html.erb

  def update
    if @participant.update_attributes(params[:participant])
      flash[:notice] = 'Participant was successfully updated.'
      redirect_to @poll
    else
      get_poll_associates
      render :action => "edit"
    end
  end

  # destroy_confirm.html.erb

  def destroy
    @participant.destroy
    flash[:notice] = "Participant destroyed."
    redirect_to @poll
  end

  private

  def get_participant
    @participant = @poll.participants.find(params[:id])
  end

end
