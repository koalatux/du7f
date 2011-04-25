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

end
