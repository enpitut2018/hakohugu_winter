class Template < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :title, presence: true, length: { maximum: 50 }
  validates :scope, presence: true
  validates :topic, presence: true
  has_many :documents
  has_many :questions, inverse_of: :template, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: :all_blank

  mount_uploader :picture, PictureUploader
  validate  :picture_size

  #has_many :contains
  #accepts_nested_attributes_for :contains


  def self.search(search,select)
    if search
      if select == 'title'
        where(['title LIKE ?', "%#{search}%"])
      elsif select == 'category'
         joins(:category).where('categories.name LIKE ?', "%#{search}%")
      else 
        all
      end
    else
      all
    end
  end



  private

  # アップロードされた画像のサイズをバリデーションする
  def picture_size
      if picture.size > 5.megabytes
          errors.add(:picture, "should be less than 5MB")
      end
  end

end
