class ChangePollType < ActiveRecord::Migration
  class Poll < ActiveRecord::Base
  end
  class Entry < ActiveRecord::Base
  end

  ANSWER_MAP = { 0 => 2, 1 => 1, 2 => 3 }

  def self.up
    Poll.all.each do |poll|
      poll.poll_type = 2
      poll.save
    end
    Entry.all.each do |entry|
      entry.answer = ANSWER_MAP[entry.answer]
      entry.save
    end
  end

  def self.down
    Poll.all.each do |poll|
      poll.poll_type = nil
      poll.save
    end
    Entry.all.each do |entry|
      entry.answer = ANSWER_MAP.invert[entry.answer]
      entry.save
    end
  end
end
