class User < ActiveRecord::Base
	has_many :photos, dependent: :destroy
	has_many :microposts, dependent: :destroy
	has_one :scrapbook, dependent: :destroy
	has_many :sb_pages, through: :scrapbook, dependent: :destroy
	has_many :scribbles, through: :scrapbook, dependent: :destroy
	before_create :create_remember_token
	before_save { self.email = email.downcase } # or email.downcase
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, length: { minimum: 6 }

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def feed
    # This is preliminary. See "Following users" for the full implementation.
    	Micropost.where("user_id = ?", id)
  	end

	private 

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end
