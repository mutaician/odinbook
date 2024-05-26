class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  validates :username, presence: true, uniqueness: true
  has_many :posts, dependent: :destroy

  # Following and followers
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def follow(other_user)
    following << other_user unless self == other_user || following?(other_user)
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  # Likes
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  # Comments
  has_many :comments, dependent: :destroy

  # Omniauth
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    unless user
      username = data['name'].parameterize.underscore
      while User.where(username: username).exists? do
        username = username + SecureRandom.hex(1)
      end
      user = User.create(username: username,
                         email: data['email'],
                         password: Devise.friendly_token[0, 20])
    end
    user
  end

end
