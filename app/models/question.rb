class Question < ApplicationRecord
    validates :qtext, presence: true, length: { maximum: 100 }
    has_many :templates, through: :contains
    has_many :contains
end
