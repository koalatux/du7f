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
    # TODO don't always load everything
    @poll = Poll.find_by_token(params[:token], :include => [ :choices, { :participants => :entries } ]) or raise ActiveRecord::RecordNotFound
  end

  def verify_admin_token
    raise ActiveRecord::RecordNotFound if @poll.admin_token != params[:admin_token]
  end

end
