class Tag < ApplicationRecord
  has_many :novels, dependent: :destroy
end
