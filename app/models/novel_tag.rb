class NovelTag < ApplicationRecord
  belongs_to :novel
  belongs_to :tag

  validates :novel_id, presence: true
  validates :tag_id, presence: true
end
