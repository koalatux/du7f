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

  def poll_created(poll)
    subject    'Your poll was created'
    recipients poll.admin_email_address
    from       'do_not_reply@koalatux.ch'

    body       :poll => poll
  end

  def poll_changed(poll)
    subject    'Your poll was changed'
    recipients poll.admin_email_address
    from       'do_not_reply@koalatux.ch'

    body       :poll => poll
  end

  def participant_created(participant)
    subject    'Activity in your poll'
    recipients participant.poll.admin_email_address
    from       'do_not_reply@koalatux.ch'

    body       :poll => participant.poll, :participant => participant
  end

  def participant_changed(participant)
    subject    'Activity in your poll'
    recipients participant.poll.admin_email_address
    from       'do_not_reply@koalatux.ch'

    body       :poll => participant.poll, :participant => participant
  end

  def participant_deleted(participant)
    subject    'Activity in your poll'
    recipients participant.poll.admin_email_address
    from       'do_not_reply@koalatux.ch'

    body       :poll => participant.poll, :participant => participant
  end

  def comment_created(comment)
    subject    'Comment in your poll'
    recipients comment.poll.admin_email_address
    from       'do_not_reply@koalatux.ch'

    body       :poll => comment.poll, :comment => comment
  end

  def comment_changed(comment)
    subject    'Comment in your poll'
    recipients comment.poll.admin_email_address
    from       'do_not_reply@koalatux.ch'

    body       :poll => comment.poll, :comment => comment
  end

  def comment_deleted(comment)
    subject    'Comment in your poll'
    recipients comment.poll.admin_email_address
    from       'do_not_reply@koalatux.ch'

    body       :poll => comment.poll, :comment => comment
  end

end
