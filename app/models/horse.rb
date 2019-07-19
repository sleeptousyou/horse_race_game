class Horse < ApplicationRecord
    belongs_to :list

    validates :race_name,presence: true
    validates :horse_name,presence: true
    validates :horse_number,presence: true
    validates :gate_number,presence: true
    validates :prize_number,presence: true
    validates :rider,presence: true
    validates :sex,presence: true
    validates :year,presence: true
end
