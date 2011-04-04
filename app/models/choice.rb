class Choice < ActiveRecord::Base
  attr_accessible :title

  belongs_to :poll

  def result
    res = {}
    self.poll.options.each{|x| res[x] = 0}
    i = self.poll.choices.sort_by{|x|x.id}.each.find_index(self)
    self.poll.participants.map do |participant|
      answer = participant.entries.sort_by{|x|x.id}[i].answer
      res[answer] += 1
    end
    res
  end
end
