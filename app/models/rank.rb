class Rank < ApplicationRecord
    belongs_to :list

    validates :list_id,presence: true
    validates :win,presence: true
    validates :second,presence: true
    validates :third,presence: true
    validates :gate1,presence: true
    validates :gate2,presence: true
end
