class List < ApplicationRecord
    has_many :horse, dependent: :destroy
    has_many :mark, dependent: :destroy
    has_many :selection, dependent: :destroy
    has_many :purchase, dependent: :destroy
    has_many :rank, dependent: :destroy
    has_many :dividend, dependent: :destroy
    has_many :board, dependent: :destroy
    has_many :ballot, dependent: :destroy
    has_many :recovery, dependent: :destroy

    
    
    validates :race_name, presence: true, uniqueness: true
    validates :year, presence: true, uniqueness: true
end
