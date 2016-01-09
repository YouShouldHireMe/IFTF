class Item 
  include Neo4j::ActiveNode

  property :type, type: String
  property :title, type: String
  property :description, type: String
  property :url, type: String
  property :image, type: String
  property :creation_date, type: Date
  property :created_at, type: DateTime
  property :updated_at, type: DateTime
  property :upvotes, type: Integer

  validates :type, :presence => true
  validates :title, :presence => true

  has_many :both, :items, type: :related
  has_many :out, :tags, type: :tags
  has_many :both, :comments, type: :comment
  has_many :both, :users, type: :upvoter
end
