class Question < ApplicationRecord
    validates :qtext, presence: true, length: { maximum: 100 }
end
