class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :validatable
  has_many :notes
  has_many :likes
  has_many :talks
  has_many :like_notes, through: :likes, source: :note
  has_many :active_relationships, class_name:  "Relationship",
                                foreign_key: "follower_id",
                                dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                foreign_key: "followed_id",
                                dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  validates :name, presence: true
  # validates :email, presence: true, uniqueness: true

  def set_image(file)
    if !file.nil?
      file_name = file.original_filename
      File.open("public/user_images/#{file_name}", 'wb'){|f| f.write(file.read)}
      self.image = file_name
    end
  end

    # ユーザーをフォローする
   def follow(other_user)
     active_relationships.create(followed_id: other_user.id)
   end

   # ユーザーをアンフォローする
   def unfollow(other_user)
     active_relationships.find_by(followed_id: other_user.id).destroy
   end

   # 現在のユーザーがフォローしてたらtrueを返す
   def following?(other_user)
     following.include?(other_user)
   end

   def matchers
    requester_ids = passive_relationships.pluck(:follower_id)
    active_relationships
      .eager_load(:followed)
      .select { |r| requester_ids.include? r.followed_id }
      .map { |r| r.followed }
  end


end
