require 'random-word'
class AnnouncementData
  def self.announcement
    return {
          :title => RandomWord.adjs.next,
          :message => RandomWord.adjs.next
    }
  end
end