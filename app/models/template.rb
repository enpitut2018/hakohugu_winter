class Template < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :title, presence: true, length: { maximum: 50 }
  #validates :scope, presence: true
  has_many :documents
  has_many :questions, thorugh :contains
  has_many :contains
  accepts_nested_attributes_for :contains
end
