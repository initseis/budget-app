class Contract < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :group_contracts
end
