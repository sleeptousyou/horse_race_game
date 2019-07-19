class Dividend < ApplicationRecord
    belongs_to :list

    validates :list_id,presence: true,uniqueness: true
    validates :win, presence: true
    validates :place1, presence: true
    validates :place2, presence: true
    validates :place3, presence: true
    validates :bracket_quinella, presence: true
    validates :quinella, presence: true
    validates :exacta, presence: true
    validates :quinella_place1, presence: true
    validates :quinella_place2, presence: true
    validates :quinella_place3, presence: true
    validates :trio, presence: true
    validates :trifecta, presence: true
end
