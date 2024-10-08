class Product < ApplicationRecord
  belongs_to :user
  has_many :renting_requests, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  has_many_attached :photos

  # for search bar
  include PgSearch::Model
  pg_search_scope :search_by_title_and_description,
  against: [ :title, :description, :category ],
  using: {
    tsearch: { prefix: true }
  }
  pg_search_scope :search_by_category,
  against: :category,
  using: {
    tsearch: { prefix: true }
  }

  # include PgSearch::Model
  # pg_search_scope :search,
  #   against: [:title, :description, :category],
  # using:{ tsearch: { prefix: true } }

  #SQL imp
  # def self.sql_search(query)
  #   sql_query = <<~ SQL
  #     title @@ :q OR
  #     description @@ :q OR
  #     category @@ :q
  #   SQL

  #   @products = Product.joins(:reviews).where(sql, q: "#{params[:q]}")
  # end
end
