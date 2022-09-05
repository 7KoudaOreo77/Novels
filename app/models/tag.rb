class Tag < ApplicationRecord
  has_many :novel_tags,dependent: :destroy, foreign_key: 'tag_id'
  # タグは複数の投稿を持つ　それは、post_tagsを通じて参照できる
  has_many :novels,through: :novel_tags

  validates :name, uniqueness: true, presence: true
end
