require 'test_helper'

class EmailNotifierTest < ActionMailer::TestCase
  test "poll_created" do
    @expected.subject = 'EmailNotifier#poll_created'
    @expected.body    = read_fixture('poll_created')
    @expected.date    = Time.now

    assert_equal @expected.encoded, EmailNotifier.create_poll_created(@expected.date).encoded
  end

  test "poll_changed" do
    @expected.subject = 'EmailNotifier#poll_changed'
    @expected.body    = read_fixture('poll_changed')
    @expected.date    = Time.now

    assert_equal @expected.encoded, EmailNotifier.create_poll_changed(@expected.date).encoded
  end

  test "participant_created" do
    @expected.subject = 'EmailNotifier#participant_created'
    @expected.body    = read_fixture('participant_created')
    @expected.date    = Time.now

    assert_equal @expected.encoded, EmailNotifier.create_participant_created(@expected.date).encoded
  end

  test "participant_changed" do
    @expected.subject = 'EmailNotifier#participant_changed'
    @expected.body    = read_fixture('participant_changed')
    @expected.date    = Time.now

    assert_equal @expected.encoded, EmailNotifier.create_participant_changed(@expected.date).encoded
  end

  test "participant_deleted" do
    @expected.subject = 'EmailNotifier#participant_deleted'
    @expected.body    = read_fixture('participant_deleted')
    @expected.date    = Time.now

    assert_equal @expected.encoded, EmailNotifier.create_participant_deleted(@expected.date).encoded
  end
end
