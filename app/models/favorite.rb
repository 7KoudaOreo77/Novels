class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :novel
  validates :user_id, uniqueness: { scope: :novel_id }
  validates :novel_id, {presence: true}
end
