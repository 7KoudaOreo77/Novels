class NovelBody < ApplicationRecord
  belongs_to :novel

  validates :body, presence: true, length: { maximum: 30000 }

  def page(number)
    pages = body.split("[page]")

    [
      pages[number.to_i - 1], #=> @body_text
      pages.size              #=> @max_page
    ]
  end
end
