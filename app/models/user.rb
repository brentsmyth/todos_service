class User < ApplicationRecord
  has_many :user_lists, dependent: :destroy
  has_many :lists, through: :user_lists

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :name, presence: true

  def self.from_omniauth(auth)
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)

    user.name = auth.info.name

    user.save if user.changed?
    user
  end

  def generate_jwt
    payload = { user_id: id, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, ENV['JWT_SECRET'], 'HS256')
  end
end
