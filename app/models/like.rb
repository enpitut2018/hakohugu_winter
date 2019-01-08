class Like < ApplicationRecord
    belongs_to :user
    belongs_to :template
    counter_culture :template
    validates :user_id, presence: true
    validates :template_id, presence: true
end
