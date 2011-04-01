class ParticipantsController < ApplicationController
  # TODO: ensure time stamp update, when only an entry gets changed

  def create
    @participant = @poll.participants.new(params[:participant])

    if @participant.save
      flash[:notice] = 'Participant was successfully created.'
      redirect_to @poll
    else
      render :action => "new" # new.html.erb
    end
  end

  def edit
    # TODO
  end

  def update
    # TODO
  end

  def destroy
    # TODO
  end

end
