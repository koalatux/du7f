class PollsController < ApplicationController
  skip_before_filter :get_poll, :only => [ :new, :index, :create ]
  before_filter :verify_admin_token, :only => [ :edit, :update, :destroy ]
  # TODO: ensure time stamp update, when only choice gets changed

  # GET /new
  def new
    @poll = Poll.new
    # TODO: variable choices count
    (0...7).each do
      @poll.choices << @poll.choices.new
    end
  end
  # new.html.erb

  # GET /
  # index.html.erb

  # POST /
  def create
    @poll = Poll.new(params[:poll])
    if @poll.save
      flash[:notice] = 'Poll was successfully created.'
      # create.html.erb
    else
      render :action => "new" # new.html.erb
    end
  end

  ## Admin ##

  # GET /0123456789abcdef.../admin/fedcba9876543210...
  # edit.html.erb

  # PUT /0123456789abcdef.../admin/fedcba9876543210...
  def update
    if @poll.update_attributes(params[:poll])
      flash[:notice] = 'Poll was successfully updated.'
      redirect_to @poll
    else
      render :action => "edit" # edit.html.erb
    end
  end

  # DELETE /0123456789abcdef.../admin/fedcba9876543210...
  def destroy
    @poll.destroy
    flash[:notice] = "Poll destroyed."
    redirect_to polls_path
  end

end
