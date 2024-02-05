class Comment
  attr_accessor :comment, :id

  def initialize(id, comment) #we take id and comment( possibility to add author) to combine the 2db
    @id = id
    @comment = comment
  end


  def save
    CSV.open("db/comment.csv", "a") do |csv|
      csv << [@id, @comment]
    end
  end

  def self.all
    all_gossip_comment = []
    CSV.read("db/comment.csv").each do |row|
      all_gossip_comment << Comment.new(row[0], row[1])
    end
    return all_gossip_comment
  end

  def self.all_with_id (id) # method to extract only comment with same id of gossip
		return self.all.select {|comment| comment.id.to_i == id}
	end

end
