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


class CommentsController < ApplicationController
  before_filter :get_comment, :except => [ :create ]

  def create
    @comment = @poll.comments.new(params[:comment])

    if @comment.save
      #EmailNotifier.deliver_participant_created(@participant) if @poll.admin_email_address #TODO
      flash[:notice] = 'Comment was successfully created.'
      redirect_to @poll
    else
      get_poll_associates
      render :template => "participants/index"
    end
  end

  #def edit
  # TODO
  #end

  #def update
  # TODO
  #end

  # destroy_confirm.html.erb

  def destroy
    @comment.destroy
    #EmailNotifier.deliver_participant_deleted(@participant) if @poll.admin_email_address #TODO
    flash[:notice] = "Comment destroyed."
    redirect_to @poll
  end

  private

  def get_comment
    @comment = @poll.comments.find(params[:id])
  end

end
