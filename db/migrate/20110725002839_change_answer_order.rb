class ChangeAnswerOrder < ActiveRecord::Migration
  class Entry < ActiveRecord::Base
  end

  ANSWER_MAP = { 1 => 1, 2 => 3, 3 => 2 }

  def self.up
    Entry.all.each do |entry|
      entry.answer = ANSWER_MAP[entry.answer]
      entry.save
    end
  end

  def self.down
    Entry.all.each do |entry|
      entry.answer = ANSWER_MAP.invert[entry.answer]
      entry.save
    end
  end
end
