class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  attr_reader :remember_token
  attr_accessor :activation_token, :reset_token
  before_save :email_downcase
  before_save :remove_spaces_from_furigana
  before_create :create_activation_digest

  has_many :playings, dependent: :restrict_with_exception
  has_many :songs, through: :playings

  validates :first_name, presence: true,
    length: {maximum: Settings.firstname_max_length}
  validates :last_name, presence: true,
    length: {maximum: Settings.lastname_max_length}
  validates :furigana, presence: true
  validates :nickname,
    length: {maximum: Settings.nickname_max_length}
  validates :email, presence: true,
    length: {maximum: Settings.email_max_length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}, allow_nil: true
  validates :joined, presence: true,
    numericality: {greater_than: Settings.year_joined}
  validates :password, presence: true,
    length: {minimum: Settings.password_min_length}, allow_nil: true
  validates :url, format: /\A#{URI::regexp(%w(http https))}\z/,
    allow_blank: true

  default_scope { order("joined DESC") }
  scope :distinct_joined, -> { unscoped.select(:joined).distinct.order(joined: :desc).pluck(:joined) }

  has_secure_password

  def full_name logged_in = true
    if logged_in
      nickname.blank? ? "#{last_name} #{first_name}" : "#{last_name} #{first_name} (#{nickname})"
    else
      handle
    end
  end

  def kana
    furigana.gsub(/\s+/, '')
  end

  def handle
    nickname.blank? ? last_name : nickname
  end

  def elder?
    joined < 2011
  end

  def admin_or_elder?
    admin? || elder?
  end

  def played? song
    songs.include? song
  end

  def remember
    @remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"

    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def current_user? user
    user == self
  end

  def forget
    update_attributes remember_digest: nil
  end

  def activate
    update_attributes activated: true
    update_attributes activated_at: Time.zone.now
  end

  def send_activation_email
    email = {user_name: self.first_name, activation_token: self.activation_token,
      mail: self.email}
    UserMailer.account_activation(email).deliver_later
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attributes reset_digest: User.digest(reset_token)
    update_attributes reset_sent_at: Time.zone.now
  end

  def send_password_reset_email
    pass_reset = {reset_token: self.reset_token, mail: self.email}
    UserMailer.password_reset(pass_reset).deliver_later
  end

  def password_reset_expired?
    reset_sent_at < Settings.hours_max.hours.ago
  end

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  private

  def email_downcase
    self.email = email.downcase unless email.nil?
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end

  def remove_spaces_from_furigana
    self.furigana = furigana.gsub(/\s+/, '')
  end
end
