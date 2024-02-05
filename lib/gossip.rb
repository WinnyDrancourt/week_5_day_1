
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
    return Gossip.all[id.to_i]
  end

  def self.update(id, author, content)
    gossips = []
    CSV.read("db/gossip.csv").each_with_index do |row, index|
      if id.to_i == (index)
          gossips << [author, content]
        else
          gossips << [row[0], row[1]]
      end
    end
    CSV.open("db/gossip.csv", "w") do |csv|
      gossips.each do |row|
        csv << row
      end
    end
  end

end
