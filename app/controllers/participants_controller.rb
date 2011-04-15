class ParticipantsController < ApplicationController
  before_filter :get_poll_associates, :only => [ :index, :edit ]
  before_filter :get_participant, :only => [ :edit, :update, :destroy ]

  # TODO: ensure time stamp update, when only an entry gets changed

  # GET /0123456789abcdef...
  def index
    @participant = @poll.participants.new
    @choices.each do |choice|
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
      render :action => "index"
    end
  end

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
