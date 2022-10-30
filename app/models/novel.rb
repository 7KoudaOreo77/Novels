class Novel < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :novel_comments, dependent: :destroy
  has_many :novel_tags,dependent: :destroy
  has_many :tags,through: :novel_tags
  has_many :favorites,dependent: :destroy

  has_many :bodies, dependent: :destroy, class_name: "NovelBody"
  accepts_nested_attributes_for :bodies

  validates :title, presence: true
  validates_associated :tags


  def get_image
    if novel.attached?
      novel
    else
      'no_image.jpg'
    end
  end

  def get_novel_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      novel.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def keyword_part(keyword, text)
    l = keyword.length + 100
    if text.length > l && text.include?(keyword)
      i = text.index(keyword)
      if i > 50
        text.slice(i-50, l)
      else
        text.slice(0,100)
      end
    else
      text.truncate(100)
    end
  end

  def save_tag(sent_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.find_by(name: old).destroy!
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end
  end



end
