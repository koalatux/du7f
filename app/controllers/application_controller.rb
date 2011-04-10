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
