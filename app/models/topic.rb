class Topic < ActiveRecord::Base
  mount_uploader :topic_img, TopicImgUploader

  validates :title, :content, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy
  
end
