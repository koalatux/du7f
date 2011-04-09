class ParticipantsController < ApplicationController
  # TODO: ensure time stamp update, when only an entry gets changed

  def create
    @participant = @poll.participants.new(params[:participant])

    # setting the associations here is needed, because of the validation in the entries
    @participant.entries.each{ |e| e.participant = @participant }

    if @participant.save
      flash[:notice] = 'Participant was successfully created.'
      redirect_to @poll
    else
      # TODO: render edit form
      render :template => "polls/show"
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
