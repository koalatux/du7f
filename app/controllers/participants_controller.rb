class ParticipantsController < ApplicationController
  before_filter :get_poll_associates, :only => [ :index ]
  before_filter :get_participant, :only => [ :destroy ]

  # TODO: ensure time stamp update, when only an entry gets changed

  # GET /0123456789abcdef...
  def index
    @participant = @poll.participants.new
    @choices.each do |choice|
      @participant.entries << choice.entries.new
    end
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
      render :action => "index"
    end
  end

  def edit
    # TODO
  end

  def update
    # TODO
  end

  def destroy
    @participant.destroy
    flash[:notice] = "Participant destroyed."
    redirect_to @poll
  end

  private

  def get_participant
    @participant = Participant.find(params[:id])
  end

end
