class Sig 
  include Neo4j::ActiveNode
  property :title, type: String
  property :url, type: String
  property :description, type: String
  property :analysis, type: String
  
  validates :title, presence: true
end
