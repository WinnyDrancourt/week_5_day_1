
class Gossip
  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end


  def save
    CSV.open("db/gossip.csv", "a") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossip = []
    CSV.foreach("db/gossip.csv") do |row|
      all_gossip << Gossip.new(row[0], row[1])
    end
    return all_gossip
  end

  def self.find(id)
    all_gossip = Gossip.all
    return all_gossip[id.to_i]
  end

end
