class Comment 
  include Neo4j::ActiveNode
  property :content, type: String

  validates :content, :presence => true

  has_one :both, :items, type: :comment
  has_one :both, :users, type: :author
end
