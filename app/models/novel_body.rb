class NovelBody < ApplicationRecord
  belongs_to :novel

  validates :body, presence: true, length: { maximum: 30000 }
end
