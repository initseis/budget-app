class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :groups, foreign_key: 'author_id', class_name: 'Group', dependent: :destroy
  has_many :contracts, foreign_key: 'author_id', class_name: 'Contract', dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
