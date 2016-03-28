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


class EmailNotifier < ActionMailer::Base

  def poll_created(poll, request)
    @request = request
    @poll = poll
    mail(from: from(request), to: poll.admin_email_address, subject: "Your new poll#{poll.quoted_title}")
  end

  def poll_changed(poll, request)
    @request = request
    @poll = poll
    mail(from: from(request), to: poll.admin_email_address, subject: "Changes at your poll#{poll.quoted_title}")
  end

  def poll_deleted(poll, request)
    @request = request
    @poll = poll
    mail(from: from(request), to: poll.admin_email_address, subject: "Removal of your poll#{poll.quoted_title}")
  end

  def participant_created(participant, request)
    @request = request
    @poll = participant.poll
    @participant = participant
    mail(from: from(request), to: participant.poll.admin_email_address, subject: "Activity in your poll#{participant.poll.quoted_title}")
  end

  def participant_changed(participant, request)
    @request = request
    @poll = participant.poll
    @participant = participant
    mail(from: from(request), to: participant.poll.admin_email_address, subject: "Activity in your poll#{participant.poll.quoted_title}")
  end

  def participant_deleted(participant, request)
    @request = request
    @poll = participant.poll
    @participant = participant
    mail(from: from(request), to: participant.poll.admin_email_address, subject: "Activity in your poll#{participant.poll.quoted_title}")
  end

  def comment_created(comment, request)
    @request = request
    @poll = comment.poll
    @comment = comment
    mail(from: from(request), to: comment.poll.admin_email_address, subject: "Comment in your poll#{comment.poll.quoted_title}")
  end

  def comment_changed(comment, request)
    @request = request
    @poll = comment.poll
    @comment = comment
    mail(from: from(request), to: comment.poll.admin_email_address, subject: "Comment in your poll#{comment.poll.quoted_title}")
  end

  def comment_deleted(comment, request)
    @request = request
    @poll = comment.poll
    @comment = comment
    mail(from: from(request), to: comment.poll.admin_email_address, subject: "Comment in your poll#{comment.poll.quoted_title}")
  end

  private

  def from(request)
    "do_not_reply@#{request.host}"
  end

end
