class Board < ApplicationRecord
    belongs_to :user
    belongs_to :list
    validates :comment, presence: true
end
