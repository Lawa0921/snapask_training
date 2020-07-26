class User < ApplicationRecord
  has_many :courses
  has_one :api_access_token
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: ["member", "teacher", "admin"]
  validates :name, presence: true, uniqueness: true
  validates :role, presence: true
  after_create :generate_keys

  private
  def new_key
    key = SecureRandom.urlsafe_base64(30).tr('_-', 'xx')
    while ApiAccessToken.where(key: key).any?
      key = SecureRandom.urlsafe_base64(30).tr('_-', 'xx')
    end
    return key
  end

  def generate_keys
    ApiAccessToken.create(user_id: self.id, key: new_key)
  end
end
