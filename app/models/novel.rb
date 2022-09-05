class Novel < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :novel_comments, dependent: :destroy
  belongs_to :tag

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 30000 }

  def get_image
    if novel.attached?
      novel
    else
      'no_image.jpg'
    end
  end

  def get_image
    unless novel.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      novel.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      novel
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
