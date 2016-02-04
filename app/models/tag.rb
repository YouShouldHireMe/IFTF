class Tag 
  include Neo4j::ActiveNode
  property :name, type: String
  property :trending_count, type: Integer

  has_many :in, :items, type: :tagged
end
