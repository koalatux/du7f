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


class PollsController < ApplicationController
  skip_before_action :get_poll, only: [:new, :index, :create]
  before_action :verify_admin_token, except: [:new, :index, :create]
  # TODO: ensure time stamp update, when only choice gets changed

  # GET /new
  def new
    @poll = Poll.new(poll_params)
    (0...5).each do
      @poll.choices.new
    end
  end

  # new.html.erb

  # GET /
  # index.html.erb

  # POST /
  def create
    @poll = Poll.new(poll_params)

    # TODO: constant string or i18n for 'Add Choice'
    if params[:commit] == 'Add Choice'
      # not saving, just adding more choices
      @poll.choices.new
      render action: 'new' # new.html.erb
      return
    end

    @poll.destroy_empty_choices!
    # setting the associations here is needed, because of the validation in the choices
    @poll.choices.each { |c| c.poll = @poll unless c.destroyed? }

    if @poll.save
      EmailNotifier.poll_created(@poll, request).deliver_now if @poll.admin_email_address
      flash[:notice] = 'Poll was successfully created.'
      # create.html.erb
    else
      render action: 'new' # new.html.erb
    end
  end

  ## Admin ##

  # GET /0123456789abcdef.../admin/fedcba9876543210.../edit
  # edit.html.erb

  # PUT /0123456789abcdef.../admin/fedcba9876543210...
  def update
    # TODO: destroy_empty_choices not implemented here, first implement ability to add choices and ask for confirmation
    if @poll.update(poll_params)
      EmailNotifier.poll_changed(@poll, request).deliver_now if @poll.admin_email_address
      flash[:notice] = 'Poll was successfully updated.'
      redirect_to @poll
    else
      render action: 'edit' # edit.html.erb
    end
  end

  # GET /0123456789abcdef.../admin/fedcba9876543210.../destroy
  # destroy_confirm.html.erb

  # DELETE /0123456789abcdef.../admin/fedcba9876543210...
  def destroy
    @poll.destroy
    EmailNotifier.poll_deleted(@poll, request).deliver_now if @poll.admin_email_address
    flash[:notice] = 'Poll destroyed.'
    redirect_to polls_path
  end

  private

  def poll_params
    if params['poll'] && !params['poll'].empty?
      params.require(:poll).permit(:author, :title, :description, :admin_email_address, :ubarlcbg, :calculation, :poll_type, :comments_allowed, :close_at, :enable_close_at, choices_attributes: [:id, :title])
    end
  end

end
