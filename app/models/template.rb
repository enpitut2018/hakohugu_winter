class Template < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :scope, presence: true
  validates :topic, presence: true
  belongs_to :user
  belongs_to :category
  has_many :documents
  has_many :questions, inverse_of: :template, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :fav_users, through: :likes, source: :user
  accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: :all_blank

  mount_uploader :picture, PictureUploader
  validate  :picture_size

  #has_many :contains
  #accepts_nested_attributes_for :contains

  #検索のメソッド
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

  # アシスタントをいいねする
  def fav(user)
    likes.create(user_id: user.id)
  end

  # アシスタントのいいねを解除する
  def unfav(user)
    likes.find_by(user_id: user.id).destroy
  end

   # 現在のユーザーがいいねしてたらtrueを返す
  def fav?(user)
    fav_users.include?(user)
  end

  private

  # アップロードされた画像のサイズをバリデーションする
  def picture_size
      if picture.size > 5.megabytes
          errors.add(:picture, "should be less than 5MB")
      end
  end

end
