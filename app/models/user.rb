class User < ApplicationRecord
    has_many :mark, dependent: :destroy
    has_many :selection, dependent: :destroy
    has_many :purchase, dependent: :destroy
    has_many :board, dependent: :destroy
    has_many :ballot, dependent: :destroy
    has_many :recovery, dependent: :destroy
    has_many :money, dependent: :destroy


    validates :name, presence: true,uniqueness: true
    validates :email, presence: true,uniqueness: true
    validates :password, presence: true
end
