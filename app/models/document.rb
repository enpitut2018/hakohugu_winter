class Document < ApplicationRecord
  belongs_to :user
  belongs_to :template
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true
  #validates :scope, presence: true
end
