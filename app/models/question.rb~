class Question < ApplicationRecord
    validates :qtext, presence: true, length: { maximum: 100 }
    validates :qdetail
    validates :example
    belongs_to :template
    #has_many :templates, through: :contains
    #has_many :contains
end
