class Contract < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :group_contracts
  validates :name, presence: true
  validates :amount, presence: true, numericality: { only_integer: false }
end
