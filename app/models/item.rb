class Item 
  include Neo4j::ActiveNode
  property :type, type: String
  property :title, type: String
  property :description, type: String
  property :url, type: String
  property :image, type: String

  validates :type, :presence => true
  validates :title, :presence => true

  has_many :both, :items, type: :related
  has_many :out, :tags, type: :tags
end
