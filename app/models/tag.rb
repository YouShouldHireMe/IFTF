class Tag 
  include Neo4j::ActiveNode
  property :name, type: String

  has_many :in, :items, type: :tagged
end
