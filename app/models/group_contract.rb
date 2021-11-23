class GroupContract < ApplicationRecord
  belongs_to :contract
  belongs_to :group
end
