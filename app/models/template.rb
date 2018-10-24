class Template < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :title, presence: true, length: { maximum: 50 }
  validates :scope, presence: true
end
